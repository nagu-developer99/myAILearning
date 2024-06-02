FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y git python3-pip python3-dev libffi-dev libssl-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install LangChain Community (might need adjustments based on version)
RUN pip3 install jupyter faiss-gpu langchain langchain-community

# Install Sentence Transformers and Ollama
RUN pip3 install sentence-transformers ollama

# Download and install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Start the Ollama service temporarily to pull the Mistral model
RUN ollama serve & \
    until ollama pull mistral; do \
        echo "Waiting for Ollama service to start..."; \
        sleep 5; \
    done
# Define working directory for Jupyter Notebook
WORKDIR /home/jupyter/

# Expose Jupyter port
EXPOSE 8888

# Start the Ollama service and then run Jupyter Notebook (no token, not recommended for production)
CMD ["bash", "-c", "ollama serve & jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''"]
