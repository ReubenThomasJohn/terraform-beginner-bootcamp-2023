terraform {
  required_providers {
    terratowns = {
        source = "local.providers/local/terratowns"
        version = "1.0.0"
    }
  }


  # cloud {
  #   organization = "terraform-beginners-bootcamp"
  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
}

provider "terratowns" {
    endpoint = var.terratowns_endpoint
    user_uuid = var.teacherseat_user_uuid
    token = var.terratowns_access_token
}

# provider "aws" {

# }

module "home_music_hosting" {
    source = "./modules/terrahome_aws"
    public_path = var.music.public_path
    user_uuid = var.teacherseat_user_uuid
    content_version = var.music.content_version
}

resource "terratowns_home" "home_music" {
  name = "My Love for Music"
  description = <<DESCRIPTION
I absolutely love music. In this page, I talk about music, why I like music, my favourite artists, and even 
link you to some of my favourite songs
  DESCRIPTION
  domain_name = module.home_music_hosting.domain_name
  # domain_name = "3fdq3gzzz.cloudfront.net"
  town = "melomaniac-mansion"
  content_version = var.music.content_version
}

module "home_chess_hosting" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.chess.public_path
    content_version = var.chess.content_version
}

resource "terratowns_home" "home_chess" {
  name = "Chess is awesome"
  description = <<DESCRIPTION
Chess is amazing. 
  DESCRIPTION
  domain_name = module.home_chess_hosting.domain_name
  # domain_name = "3fdq3gzzz.cloudfront.net"
  # town = "the-nomad-pad"
  town = "missingo"
  content_version = var.music.content_version
}