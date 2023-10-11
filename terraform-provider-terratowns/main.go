package main

import {
	"fmt",
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema",
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
}

func main() {
	plugin.Serve(&plygin.ServeOpts{
		ProviderFunc: Provider
	})
	fmt.Println("Hello, world!")	
}

func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourceMap:
		DataSourcesMap:
		Schema:
	}
}