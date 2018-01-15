xquery version "1.0-ml";

import module namespace cpf = "http://marklogic.com/cpf" at "/MarkLogic/cpf/cpf.xqy";
import module namespace wfr="http://marklogic.com/workflow-runtime" at "/app/models/workflow-runtime.xqy";

declare namespace wf="http://marklogic.com/workflow";
declare namespace prop = "http://marklogic.com/xdmp/property";

declare variable $cpf:document-uri as xs:string external;
declare variable $cpf:transition as node() external;
declare variable $cpf:options as element() external;

try {
  let $st := fn:current-dateTime()
  let $_ := xdmp:log("MarkLogic Workflow initial selection action called for: "||$cpf:document-uri)

  (: determine next state by URI of the process document :)
  let $middleName := fn:substring-before(fn:substring-after($cpf:document-uri,"/workflow/processes/"),"/")
  let $_ := xdmp:log("Document is for process: " || $middleName)
  let $stateOverride := xs:anyURI("http://marklogic.com/states/" || $middleName || "__start")
  let $_ := xdmp:log("Next state is:-")
  let $_ := xdmp:log($stateOverride)

  (: Allow state transition to happen :)
  return wfr:complete( $cpf:document-uri, $cpf:transition, $stateOverride, $st )
} catch ($e) {
  (
    xdmp:log("Exception raised in executing workflowInitialSelection:-"),
    xdmp:log($e),
    wfr:failure( $cpf:document-uri, $cpf:transition, $e, () )
  )
}