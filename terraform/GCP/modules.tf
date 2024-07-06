module "load_balancer" {
  source          = "./modules/load_balancer_geo"
  vpc_network     = module.networking.gen_vpc_id
  geo_sub_network = module.networking.geo_subnet_id
  env             = var.env
  region          = var.region
  project         = var.project
  zone            = var.zone
  app             = var.app
}

module "gogs_db" {
  source  = "./modules/gogs_db"
  vpc_id  = module.networking.gen_vpc_id
  env     = var.env
  region  = var.region
  project = var.project
  app     = var.app
}

module "geo_db" {
  source  = "./modules/geo_db"
  vpc_id  = module.networking.gen_vpc_id
  env     = var.env
  region  = var.region
  project = var.project
  app     = var.app
}

module "gogs_infrastructure" {
  source    = "./modules/gogs_infrastructure"
  vpc_id    = module.networking.gen_vpc_id
  subnet_id = module.networking.gogs_subnet_id
  env       = var.env
  region    = var.region
  project   = var.project
  zone      = var.zone
  app       = var.app
}

module "networking" {
  source  = "./modules/networking"
  env     = var.env
  region  = var.region
  project = var.project
  app     = var.app
}