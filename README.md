# APTrust Admin Interface (Rubydora Implementation)

Rather than using the full Hydra stack to interact with Fedora, this application aims to serialize traditional Rails classes (in this case Mongoid::Document objects) to XML and post them to Fedora using the Rubydora.

The logic for serializing the objects and the code to handle the Rubydora negotiations are to be found in the [fedora_rails](https://github.com/uvalib-dcs/fedora_rails) gem currently being developed as an experiment at UVA.  