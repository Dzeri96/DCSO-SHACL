# DCSO maDMP constraints implementation in SHACL

This is a SHACL version of the [JSON Schema v1.1](https://github.com/RDA-DMP-Common/RDA-DMP-Common-Standard/tree/master/examples/JSON/JSON-schema/1.1). For differences and implementation details take a look at the following two sections.

## Decisions we made when modelling

- The `example` field is skipped.
- The `title` from JSON Schema corresponds to `sh:name` in SHACL.
- We wanted to re-use the `contact_id` and `contributor_id` shapes, though there doesn't seem to be a way to reuse a propertyShape with a different `sh:path`.
- JSON-Schema properties of type `array` could not have been modelled exactly like described in the original format (mostly regarding the title and description).
- Setting constraints on `rdf:List` was only possible with the [DASH](https://www.topquadrant.com/constraints-on-rdflists-using-shacl/) vocabulary from TopQuadrant.
For some reason, [dcso-json](https://github.com/fekaputra/dcso-json/tree/c11bd17f894cce0d0c31610db054d4ed9888994a) sometimes chooses to translate json arrays into `rdf:List`s, like with the `role` property, while other times it just repeats the same relation with different values, like in the `data_quality_assurance` case.
- The `uniqueItems` construct is enforced by a somewhat convoluted SPARQL constraint, though it allows us to produce a nice error message.
- Even though the `description` property shows up twice in very similar forms in datasets and their distributions, we explicitly wrote it twice instead of handling it separately, since the rest of the schema follows this spirit.
- For validating a URI, we used a fairly permissive custom regex. A URI can get very complex and it should be discussed how strict we want the validation to be.
- For the cost value, we decided to include both `xsd:integer` and `xsd:float` as those should correspond to the `number` JSON-Schema type. We also decided to further restrict the minimum value to 0.
- When validating the date or date-time fields, we allow for semantically incorrect dates like the 31st of February. This was done to keep the regular expression somewhat simple.


## Errors we found in the original JSON Schema or Repository
- The `storage_type` example is missing in the RDA-DMP-Common README File.
- The `url` property in `host` has the wrong title. (JSON Schema 1.1).
- The `preservation_statement` field is not present in `madmp-1.1.0.jsonld` context file, so this field won't get translated .

## JSON-Schema Validation attempts
When trying to compare our implementation to the original JSON-Schema, we ran into some issues.
It seems like the different JSON-Schema validator implementations vary greatly in their spec conformance.

First, we tried the NPM package [ajv-cli v5.0.0](https://www.npmjs.com/package/ajv-cli).
It gave us the following error:
```shell
ajv -s maDMP-1.1.schema.json -d ../dcso-json/examples/gdp_sunshine-maDMP.json
schema maDMP-1.1.schema.json is invalid
error: unknown format "email" ignored in schema at path "#/properties/dmp/properties/contact/properties/mbox"
```

Then we tried the java implementation, [Snow v0.16.0](https://github.com/ssilverman/snowy-json).
It gave us a completely different error:
```shell
[ERROR] Failed to execute goal org.codehaus.mojo:exec-maven-plugin:3.0.0:java (main) on project snowy-json: An exception occured while executing the Java class. com.qindesign.json.schema.MalformedSchemaException: #/properties/dmp/$id: invalid plain name -> [Help 1]
```

Finally, we tried a python implementation, [jsonschema 3.2.0](https://github.com/Julian/jsonschema).
Although the schema was accepted as correct, the validator seems to have poor support for the `format` property, as the `email` field in an input instance could be manipulated arbitrarily, and it would still pass validation.

Due to such implementation inconsistencies, we decided to forego validation comparisons with JSON-Schema, and just provide some examples of valid and invalid instances for our SHACL implementation.


## Validation
The folder `instances/turtle` contains 11 correct instances generated with [dcso-json](https://github.com/fekaputra/dcso-json/tree/c11bd17f894cce0d0c31610db054d4ed9888994a), and one hand-crafted file (`invalid_many_examples.ttl`), which contains the following errors:
- Invalid `terms:created` in `madmp:DMP` - line 23
- Missing `terms:title` in `madmp:DMP` - line 26
- Invalid `foaf:mbox` in `m̀admp:contact` - line 27
- Non-unique values in `madmp:role` - line 38
- Negative `madmp:value` in `madmp:cost` -line 43
- Ivalid `terms:issued` in `madmp:dataset` - line 46
- Invalid url in `madmp:license_ref` - line 68
- Invalid `madmp:language` in `madmp:metadata` - line 75
- Too many `terms_identifier` in `madmp:dmp_id` - line 338

The output of each validation run is contained in the `validation_results/shacl` subfolder.

### Running the validation locally

To validate the files in the `instances` folder and re-generate the `validation_results/shacl` subfolder, follow these steps:

1. Download the [binary distribution](https://repo1.maven.org/maven2/org/topbraid/shacl/1.3.2/shacl-1.3.2-bin.zip) of TopBraid's SHACL validator and extract it into a directory above this repo.
2. Make sure the shell scripts in the validator's `bin` directory are executable by running `chmod +x FILE`.
3. Run the `validate.sh` script.

## Contributing
As we plan to create a pull request to the main DCSO repository once the individual details have been discussed, we are open to any input via the issue mechanism on GitHub.

## Authors
- Filip Darmanovic (e1527089@student.tuwien.ac.at)
- Jovan Petrovic (e1627772@student.tuwien.ac.at)