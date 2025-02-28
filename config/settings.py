from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Database configuration
database_config = {
    "user": os.getenv("DB_USER", "default_user"),
    "password": os.getenv("DB_PASSWORD", "default_password"),
    "host": os.getenv("DB_HOST", "default_host"),
    "port": os.getenv("DB_PORT", "default_port"),
    "database": os.getenv("DB_NAME", "default_database"),
}
