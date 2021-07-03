# DCSO maDMP constraints implementation in SHACL

This is a SHACL version of the [JSON Schema v1.1](https://github.com/RDA-DMP-Common/RDA-DMP-Common-Standard/tree/master/examples/JSON/JSON-schema/1.1). For differences and implementation details take a look at the following two sections.

## Decisions we made

- The `example` field is skipped.
- We decided to further restrict the `mbox` property in `contact` by adding an email regex (Maybe an RFC one is needed).
- The `title` from JSON Schema is `sh:name`.
- We wanted to re-use the `contact_id` and `contributor_id` shapes, though there doesn't seem to be a way to reuse a propertyShape with a different path.
- The `role` node could not have been modelled exactly like in the JSON-LD (mostly regarding the title).
- Setting constraints on `rdf:List`, was only possible with the [DASH](https://www.topquadrant.com/constraints-on-rdflists-using-shacl/) vocabulary from TopQuadrant. For some reason, (dcso-json)[https://github.com/fekaputra/dcso-json/tree/c11bd17f894cce0d0c31610db054d4ed9888994a] sometimes chooses to translate json arrays into `rdf:List`s, like with the `role` property, while other times it just repeats the same relation with different values, like in the `data_quality_assurance`.
- The `uniqueItems` construct is enforced by a somewhat convoluted SPARQL constraint, though it allows us to produce a nice error message.
- Even though the `description` property shows up twice in very similar forms in datasets and their distributions, we explicitly wrote it twice instead of handling it separately, since the rest of the schema follows this spirit.
- For validating a URI, we used a fairly permissive custom regex. A URI can get very complex and it should be discussed how strict we want the validation to be.
- For the cost value, we decided to include both `xsd:integer` and `xsd:float` as those should correspond to the `number` JSON-Schema type. We also decided to further restrict the minimum value to 0.
- When validating the date or date-time fields, we allow for semantically incorrect dates like the 31st of February. This was done to keep the regular expression somewhat simple.


## Errors we found in the original JSON Schema or Repository
- The `storage_type` example is missing in the RDA-DMP-Common README File.
- The `url` property in `host` has the wrong title. (JSON Schema 1.1).
- The `preservation_statement` field is not present in `madmp-1.1.0.jsonld` context file, so this field won't get translated .

## Validation
To validate the files in the `instances` folder, follow these steps:

1. Download the [binary distribution](https://repo1.maven.org/maven2/org/topbraid/shacl/1.3.2/shacl-1.3.2-bin.zip) of TopBraid's SHACL validator and extract it into a directory above this repo's.
2. Make sure the shell scripts in the validator's `bin` directory are executable by running `chmod +x FILE`.
3. Run the `validate.sh` script.

## Contributing
As we plan to create a pull request once the individual details have been discussed, we are open to any criticisms/changes via the PR mechanism on GitHub.

## Authors
- Filip Darmanovic (e1527089@student.tuwien.ac.at)
- Jovan Petrovic (e1627772@student.tuwien.ac.at)