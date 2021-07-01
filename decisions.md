# Decisions we made

- The `example` field is skipped.
- We decided to further restrict the `mbox` property in `contact` by adding an email regex (Maybe an RFC one is needed).
- The `title` from JSON Schema is `sh:name`.
- We wanted to re-use the `contact_id` and `contributor_id` shapes, though there doesn't seem to be a way to reuse a propertyShape with a different path.
- The `role` node could not have been modelled exactly like in the JSON-LD (mostly regarding the title).
- Setting constraints on `rdf:List`, which is what json arrays get turned into when translating them to an RDF serialization, was only possible with the [DASH](https://www.topquadrant.com/constraints-on-rdflists-using-shacl/) vocabulary from TopQuadrant.
- The `uniqueItems` construct is enforced by a somewhat convoluted SPARQL constraint, though it allows us to produce a nice error message.