import ollama
from langchain_community.vectorstores import FAISS
from langchain_community.embeddings import HuggingFaceEmbeddings

from langchain_community.document_loaders import TextLoader
from langchain_text_splitters import CharacterTextSplitter

loader = TextLoader(r'pay_doc.txt')
documents = loader.load()
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
docs = text_splitter.split_documents(documents)

embeddings=HuggingFaceEmbeddings()
db = FAISS.from_documents(docs, embeddings)

# def get_answer( query):
while True:
    query = input(">>Question<< \n")
    results = db.similarity_search(query, k=5)
    relevant_texts = [result.page_content for result in results]
    context = "\n\n".join(relevant_texts)
    prompt = f"Based on the following documents:\n\n{context}\n\nAnswer the following question:\n{query}"

    result = ollama.generate(model='mistral', prompt = prompt)
    print(result['response'])
