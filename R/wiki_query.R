
.substrNS <- function (str0, ns)
{
  regex <- paste("^", ns[2], sep = "")
  gsub(regex, paste(ns[1], ":", sep = ""), str0)
}

.qnames <- function (str0, ns_list)
{
  if (!length(ns_list))
    str0
  else .substrNS(.qnames(str0, ns_list[-1:-2]), ns_list[1:2])
}

.interpret_type <- function (type, literal, ns)
{
  qname <- .qnames(type, ns)
  if (unlist(qname) == unlist(type))
    type_uri <- paste("<", type, ">", sep = "")
  else type_uri <- qname
  if (type == "http://www.w3.org/2001/XMLSchema#double" ||
      type == "http://www.w3.org/2001/XMLSchema#float" || type ==
      "http://www.w3.org/2001/XMLSchema#decimal")
    as.double(literal)
  else if (type == "http://www.w3.org/2001/XMLSchema#integer" ||
           type == "http://www.w3.org/2001/XMLSchema#int" || type ==
           "http://www.w3.org/2001/XMLSchema#long" || type == "http://www.w3.org/2001/XMLSchema#short" ||
           type == "http://www.w3.org/2001/XMLSchema#byte" || type ==
           "http://www.w3.org/2001/XMLSchema#nonNegativeInteger" ||
           type == "http://www.w3.org/2001/XMLSchema#unsignedLong" ||
           type == "http://www.w3.org/2001/XMLSchema#unsignedShort" ||
           type == "http://www.w3.org/2001/XMLSchema#unsignedInt" ||
           type == "http://www.w3.org/2001/XMLSchema#unsignedByte" ||
           type == "http://www.w3.org/2001/XMLSchema#positiveInteger" ||
           type == "http://www.w3.org/2001/XMLSchema#nonPositiveInteger" ||
           type == "http://www.w3.org/2001/XMLSchema#negativeInteger")
  as.integer(literal)
  else if (type == "http://www.w3.org/2001/XMLSchema#boolean")
    as.logical(literal)
  else if (type == "http://www.w3.org/2001/XMLSchema#string" ||
           type == "http://www.w3.org/2001/XMLSchema#normalizedString")
    literal
  else if (type == "http://www.w3.org/2001/XMLSchema#dateTime")
    as.POSIXct(literal, format = "%FT%T")
  else if (type == "http://www.w3.org/2001/XMLSchema#time")
    as.POSIXct(literal, format = "%T")
  else if (type == "http://www.w3.org/2001/XMLSchema#date")
    as.POSIXct(literal)
  else if (type == "http://www.w3.org/2001/XMLSchema#gYearMonth")
    as.POSIXct(literal, format = "%Y-%m")
  else if (type == "http://www.w3.org/2001/XMLSchema#gYear")
    as.POSIXct(literal, format = "%Y")
  else if (type == "http://www.w3.org/2001/XMLSchema#gMonthDay")
    as.POSIXct(literal, format = "--%m-%d")
  else if (type == "http://www.w3.org/2001/XMLSchema#gDay")
    as.POSIXct(literal, format = "---%d")
  else if (type == "http://www.w3.org/2001/XMLSchema#gMonth")
    as.POSIXct(literal, format = "--%m")
  else paste("\"", literal, "\"^^", type_uri, sep = "")
}

.get_value <- function (node, ns)
{
  if (is.null(node)) {
    return(NA)
  }
  doc <- XML::xmlDoc(node)
  uri = XML::xpathSApply(doc, "/s:uri", XML::xmlValue, namespaces = SPARQL::sparqlns)
  if (length(uri) == 0) {
    literal = XML::xpathSApply(doc, "/s:literal", XML::xmlValue, namespaces = SPARQL::sparqlns)
    if (length(literal) == 0) {
      bnode = XML::xpathSApply(doc, "/s:bnode", XML::xmlValue, namespaces = SPARQL::sparqlns)
      if (length(bnode) == 0) {
        "***oops***"
      }
      else {
        paste("_:genid", bnode, sep = "")
      }
    }
    else {
      lang = XML::xpathApply(doc, "/s:literal", XML::xmlGetAttr,
                             "xml:lang", namespaces = SPARQL::sparqlns)
      if (is.null(lang[[1]])) {
        type = XML::xpathApply(doc, "/s:literal", XML::xmlGetAttr,
                               "datatype", namespaces = SPARQL::sparqlns)
        if (is.null(type[[1]])) {
          literal
        }
        else {
          .interpret_type(type, literal, ns)
        }
      }
      else {
        paste("\"", literal, "\"@", lang, sep = "")
      }
    }
  }
  else {
    qname = .qnames(uri, ns)
    if (qname == uri)
      paste("<", uri, ">", sep = "")
    else qname
  }
}

.get_attr <- function (attrs, DOM, ns)
{
  rs <- XML::getNodeSet(DOM, "//s:result", namespaces = SPARQL::sparqlns)
  t(sapply(rs, function(r) {
    sapply(attrs, function(attr) {
      .get_value(XML::getNodeSet(XML::xmlDoc(r), paste("//s:binding[@name=\"",
                                                       attr, "\"]/*[1]", sep = ""), namespaces = SPARQL::sparqlns)[[1]],
                 ns)
    }, simplify = FALSE)
  }, simplify = TRUE))
}

.noBrackets <- function (ns)
{
  sapply(ns, function(br_ns) {
    if (substr(br_ns, 1, 1) == "<")
      substr(br_ns, 2, nchar(br_ns) - 1)
    else br_ns
  })
}

.SPARQL <- function (url = "http://localhost/", query = "", update = "",
                     ns = NULL, param = "", extra = NULL, curl_args = NULL,
                     parser_args = NULL)
{
  if (!is.null(extra)) {
    extrastr <- paste("&", sapply(seq(1, length(extra)),
                                  function(i) {
                                    paste(names(extra)[i], "=", URLencode(extra[[i]]),
                                          sep = "")
                                  }), collapse = "&", sep = "")
  }
  else {
    extrastr <- ""
  }
  tf <- tempfile()
  if (query != "") {
    if (param == "") {
      param <- "query"
    }
    tf <- do.call(RCurl::getURL, append(list(url = paste(url,
                                                         "?", param, "=", gsub("\\+", "%2B", URLencode(query,
                                                                                                       reserved = TRUE)), extrastr, sep = ""), httpheader = c(Accept = "application/sparql-results+xml")),
                                        curl_args))
    DOM <- do.call(XML::xmlParse, append(list(tf), parser_args))
    if (length(XML::getNodeSet(DOM, "//s:result[1]", namespaces = SPARQL::sparqlns)) ==
        0) {
      rm(DOM)
      df <- data.frame(c())
    }
    else {
      attrs <- unlist(XML::xpathApply(DOM, paste("//s:head/s:variable",
                                                 sep = ""), namespaces = SPARQL::sparqlns, quote(XML::xmlGetAttr(x,
                                                                                                                 "name"))))
      ns2 <- .noBrackets(ns)
      res <- .get_attr(attrs, DOM, ns2)
      df <- data.frame(res)
      rm(res)
      rm(DOM)
      n = names(df)
      for (r in 1:length(n)) {
        name <- n[r]
        df[name] <- as.vector(unlist(df[name]))
      }
    }
    list(results = df, namespaces = ns)
  }
  else if (update != "") {
    if (param == "") {
      param <- "update"
    }
    extra[[param]] <- update
    do.call(RCurl::postForm, append(list(url, .params = extra),
                             curl_args))
  }
}



#' Send queries to the Wikidata knowledge graph and receive results as dataframe.
#'
#' @description
#' `wiki_query()` sends a SPARQL query to the Wikidata knowledge graph and collects the results in a dataframe.
#'
#' @param qry A character string representing a SPARQL query to be run against the Wikidata knowledge graph.
#' @param raw_results Logical.  If TRUE, the results of the query will not be cleaned to remove escaped quotes and language tags.
#'
#' @return A dataframe of result
#'
#' @examples
#' # List five diseases
#' query <- 'SELECT ?item ?itemLabel WHERE {
#'   ?item wdt:P31 wd:Q12136. #instance of disease
#'   SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
#' }
#' LIMIT 5'
#' wiki_query(query)

wiki_query <- function(qry, raw_results = FALSE) {

  endpoint <- "https://query.wikidata.org/sparql"
  useragent <- paste("WDQS", R.version.string)

  qd <- .SPARQL(endpoint, qry, curl_args = list(useragent = useragent))
  df <- as.data.frame(qd$results)

  if (!raw_results) {
    df <- df %>%
      dplyr::mutate(dplyr::across(tidyselect::vars_select_helpers$where(is.character), function(x) gsub('\"', '', x))) %>%
      dplyr::mutate(dplyr::across(tidyselect::vars_select_helpers$where(is.character), function(x) gsub('@(.*)', '', x)))
  }

  df
}
