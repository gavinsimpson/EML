<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{Publishing to the KNB}
-->






### Publishing to the KNB

We can also publish to the KNB (Knowledge Network for Biocomplexity,
a data repository provided by NCEAS) using the `dataone` R package.
KNB offers several advantages over alternative repositories such
as figshare or [Dryad](http://datadryad.org) when publishing EML
metadata. The KNB "speaks" EML, so it is unnecessary to provide
repository-specific additional metadata such as description, category or
tag -- all necessary information will be extracted from the EML. This is
also much more thorough than other repositories: we can search the KNB
network by specific taxonomic or geographic coverage, or even down at
the level of individual attribute or column headings, rather than being
limited to more generic metadata.  Lastly, KNB is a member node of the
DataONE repository, making the resulting data files immediately part of a
much larger network for ecological, earth and environmental science data.

_Note: this example assumes `dataone` is installed, even though it is not 
required to use EML and run the examples in the other sections.  See the 
`dataone` documentation for authenticating `dataone` with a user account_

```r
library(EML)
ids <- eml_publish("EML_example.xml", destination="KNB", permanent=FALSE)
```


_NB:_ To avoid clutter, we should publish only real research data to
the KNB production servers (by setting `permanent=TRUE`).  By default,
`eml_publish` assumes `permanent=FALSE` when sending data to the KNB,
and will publish to the development server instead.  The development
server works as a testing platform, providing all the same features as
the production platform but without permanent storage -- all data will
be deleted regularly.  The development server is not as stable as the
production server, so if the command fails, please try again later.


<!--
Test data shows up on the test server, followed by the identifer, at `paste0("(https://mn-demo-5.test.dataone.org/knb/d1/mn/v1/object/", ids[["eml"]])`

This returns the object identifiers for the EML metadata, the csv file, and the package itself.  We can read in the EML directly from its unique identifier using `eml_read`. We must wait about four minutes first for the entry to be completely registered in the dataone repository.  (Note that because we are using the development server, `permanent=FALSE`, this file will dissapear after a few days.)

```r
Sys.sleep(60*4)
eml <- eml_read(paste0("(https://mn-demo-5.test.dataone.org/knb/d1/mn/v1/object/", ids[["eml"]]))
```
-->

<!-- In return, figshare provides the object with a DOI, which is added to the EML.  
-->

<--! Too detailed for this vignette

For the sake of completeness, the explicitly figshare metadata is also written into a 
dedicated `<additionalMetadata>` node with the attribute `id = figshare`.  This allows
us to distinguish between metadata that is an is not available to figshare's indexing,
e.g. if we use the figshare search tool.  

-->

