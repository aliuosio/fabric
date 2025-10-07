# Fabric Stack

This stack provides a multi-service environment for AI, search, and application development. It includes the following services:

## Services

- **Ollama**: Runs large language models locally with GPU support.
- **Fabric**: Custom application service (Go-based).
- **SearxNG**: Privacy-respecting metasearch engine.

## How to Start

1. **Clone the repository** and navigate to the project directory:
   ```sh
   git clone https://github.com/aliuosio/fabric.git
   cd fabric
   ```

2. **Configure environment variables**  
   Edit `.env` in the project root to set required variables (see `docker-compose.yml` for references).

3. **Start the stack**  
   Run the following command:
   ```sh
   docker compose up -d
   ```

## Notes

- Ollama requires GPU support (NVIDIA by default).
- Data and configuration are persisted in your home directory and project folders.
- Stop the stack with:
   ```sh
   docker compose down
   ```

## Troubleshooting

- Ensure Docker is installed and running.
- Check `.env` for correct variable values.
- For GPU issues, verify your drivers and Docker GPU setup.

