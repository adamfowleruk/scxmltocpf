
## How to install a process model in to MarkLogic Workflow

There are many process modelling standards available, including XPDL 2, BPMN 2, and SCXML, not to mention BPEL and
properietary formats.

This project describes a generic way to convert a process model for invocation within MarkLogic, and provides a
reference implementation for SCXML.

### Modelling

A modelling tool is out of scope of this project, although creating a 'MarkLogic palette' for a process tool
would be a good idea to make modelling simple for process model creators.

The Eclipse BPMN2 modeller is a good option, with support for pluggable runtime definitions and profiles. Its relatively
easy to define a MarkLogic runtime and set of custom tasks, and hide any BPMN2 tasks that we do not support the
execution of.

Also view the [BPMN2 specification summary document](bpmn2-spec.md)

### Importing

In future a model import User Interface (UI) could be created. This is out of scope of this project. This project
only deals with providing a workflow engine reference implementation over MarkLogic CPF. A variety of UI approaches
should be usable against this project.

A set of REST API extensions have been created to assist with saving process models in to MarkLogic, and publishing
them (activating them in CPF).

- PUT /v1/resource/processmodel - Creates or create a new major-minor version of a process model. MIME type differs
- GET /v1/resource/processmodel - Fetches the latest, or specified version, of a process model in its original format
- POST /v1/sresource/processmodel - Publishes a process model (creates a CPF pipeline, and enables it, updating the CPF directory or collection scope definition)
- DELETE /v1/resource/processmodel - Removes the process model's pipeline directory or collection scope definition (so no new processes can be started. Leaves currently running processes unaffected)
- GET /v1/resource/processmodelsearch - Search API compatible interface that restricts results to process model definitions

Also see the [REST API document](RESTAPI.md)