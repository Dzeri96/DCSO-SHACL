# Decisions we made

- The `example` field is skipped.
- We decided to further restrict the `mbox` property in `contact` by adding an email regex (Maybe an RFC one is needed).
- The `title` from JSON Schema is `sh:name`.
- We wanted to re-use the `contact_id` and `contributor_id` shapes, though there doesn't seem to be a way to reuse a propertyShape with a different path.
- The `role` node could not have been modelled exactly like in the JSON-LD (mostly regarding the title).
- Setting constraints on `rdf:List`, was only possible with the [DASH](https://www.topquadrant.com/constraints-on-rdflists-using-shacl/) vocabulary from TopQuadrant. For some reason, (dcso-json)[https://github.com/fekaputra/dcso-json/tree/c11bd17f894cce0d0c31610db054d4ed9888994a] sometimes chooses to translate json arrays into `rdf:List`s, like with the `role` property, while other times it just repeats the same relation with different values, like in the `data_quality_assurance`.
- The `uniqueItems` construct is enforced by a somewhat convoluted SPARQL constraint, though it allows us to produce a nice error message.
- Even though the `description` property shows up twice in very similar forms in datasets and their distributions, we explicitly wrote it twice instead of handling it separately, since the rest of the schema follows this spirit.
- For validating a URI, we used a fairly permissive custom regex. A URI can get very complex and it should be discussed how strict we want the validation to be.

# Errors we found in the original JSON Schema or Repository
- The `storage_type` example is missing in the RDA-DMP-Common README File
- The `url` property in `host` has the wrong title. (JSON Schema 1.1)
- The `preservation_statement` field is not present in `madmp-1.1.0.jsonld` context file, so this field won't get translated .