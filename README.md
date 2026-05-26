# Simple Naive RAG with LangSmith

This is a small RAG pipeline for the included PDF:

`Documents -> Load Data -> Chunking -> Embeddings -> ChromaDB -> User Query -> Retrieval -> Prompt + Context -> Groq LLM -> Final Answer`

The current document is:

- `data/Artificial Intelligence Act - Wikipedia.pdf`

## Setup

Create a `.env` file from the example:

```powershell
Copy-Item .env.example .env
```

Then fill in:

- `GROQ_API_KEY`
- `LANGSMITH_API_KEY`, if you want traces in LangSmith

LangSmith tracing is enabled through these environment variables:

```text
LANGSMITH_TRACING=true
LANGSMITH_PROJECT=Simple Naive RAG
```

For deployed frontend builds, set this frontend environment variable to the backend URL:

```text
VITE_API_BASE=https://your-backend-url
```

## Run

Start the full React + Python app with one command:

```powershell
.\run_app.bat
```

Then open:

```text
http://127.0.0.1:8000
```

This builds the React frontend and serves it from the Python backend.

Check whether both are running:

```powershell
.\check_app.bat
```

Build the vector store:

```powershell
.\run.bat --index
```

Ask a question:

```powershell
.\run.bat --ask "What is the Artificial Intelligence Act?"
```

Or start interactive mode:

```powershell
.\run.bat
```

Optional: start the Python backend only:

```powershell
.\run_backend.bat
```

Optional: start the React frontend preview separately:

```powershell
.\run_frontend.bat
```

Then open:

```text
http://127.0.0.1:5173
```

The React frontend builds and then serves the app locally. It lets you upload documents, rebuild ChromaDB, ask questions in a chat screen, and view readable source evidence.

If you are running the frontend for the first time, install its dependencies once:

```powershell
cd frontend
npm install
```

## How It Works

1. Reads PDFs, `.txt`, and `.md` files from `data/`.
2. Splits text into overlapping chunks.
3. Creates simple local TF-IDF embeddings.
4. Saves TF-IDF embeddings and chunk metadata in ChromaDB under `chroma_db/`.
5. Retrieves the most similar chunks for a question.
6. Sends only the retrieved context to the LLM.
7. Uses a strict prompt: answer only from context, otherwise say `Not found`.
8. Sends traces to LangSmith when LangSmith environment variables are configured.

## Notes

This is intentionally naive and simple. It uses ChromaDB as the vector database, TF-IDF for simple local embeddings, and Groq for the final LLM answer.

## GitHub Push

From the project folder:

```powershell
git init
git add .
git commit -m "Build naive RAG chatbot"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git push -u origin main
```

Do not push `.env`, `chroma_db/`, `vector_store/`, `frontend/node_modules/`, or `frontend/dist/`. They are already ignored.

## Vercel Deploy

This repository includes `vercel.json` for deploying the React frontend from `frontend/`.

In Vercel:

1. Import the GitHub repository.
2. Select the account/team: `keerthis-projects-6ce39bff`.
3. Keep the root directory as the repository root.
4. Vercel will use `vercel.json`:
   - Build command: `cd frontend && npm install && npm run build`
   - Output directory: `frontend/dist`
5. Add environment variable:

```text
VITE_API_BASE=https://your-backend-url
```

Important: Vercel should host the React frontend. The Python FastAPI + ChromaDB backend should be hosted separately because it needs a persistent backend process and local ChromaDB storage.
