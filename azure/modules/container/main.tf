resource "random_string" "iovision_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_container_group" "iovision_app" {
  name                = "iovision-${var.app_name}-${random_string.iovision_suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  container {
    name   = "iovision-postgres"
    image  = "postgres:${var.postgres_version}"
    cpu    = var.db_cpu_cores
    memory = var.db_memory_gb

    ports {
      port     = 5432
      protocol = "TCP"
    }

    environment_variables = {
      POSTGRES_USER     = var.postgres_user
      POSTGRES_PASSWORD = var.postgres_password
      POSTGRES_DB       = var.postgres_db
    }

    volume {
      name       = "iovision-postgres-data"
      mount_path = "/var/lib/postgresql/data"
      read_only  = false
    }
  }

  container {
    name   = "iovision-pgadmin"
    image  = "dpage/pgadmin4:${var.pgadmin_version}"
    cpu    = var.pgadmin_cpu_cores
    memory = var.pgadmin_memory_gb

    ports {
      port     = 5050
      protocol = "TCP"
    }

    environment_variables = {
      PGADMIN_DEFAULT_EMAIL    = var.pgadmin_email
      PGADMIN_DEFAULT_PASSWORD = var.pgadmin_password
    }
  }

  container {
    name   = "iovision-backend"
    image  = var.backend_image
    cpu    = var.backend_cpu_cores
    memory = var.backend_memory_gb

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      DB_URL      = "jdbc:postgresql://localhost:5432/${var.postgres_db}"
      DB_USERNAME = var.postgres_user
      DB_PASSWORD = var.postgres_password
      # Ajoutez d'autres variables d'environnement si nécessaire
    }
  }

  container {
    name   = "iovision-frontend"
    image  = var.frontend_image
    cpu    = var.frontend_cpu_cores
    memory = var.frontend_memory_gb

    ports {
      port     = 80
      protocol = "TCP"
    }
  }


  tags = merge(var.tags, {
    iovision-module = "container-app"
    iovision-app    = var.app_name
  })
}