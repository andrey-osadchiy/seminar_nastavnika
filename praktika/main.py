from fastapi import FastAPI
import sqlite3
from pydantic import BaseModel

app = FastAPI()

class SearchQuery(BaseModel):
    keyword: str

def check_table():
    conn = sqlite3.connect("22.db")
    c = conn.cursor()
    c.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = [row[0] for row in c.fetchall()]
    conn.close()
    if 'userin' not in tables:
        raise Exception(f"Table 'userin' not found in 22.db. Available tables: {tables}")

@app.on_event("startup")
def startup_event():
    check_table()

@app.post("/search")
async def search(query: SearchQuery):
    keyword = query.keyword.strip()
    if not keyword:
        return {"results": []}
    conn = sqlite3.connect("22.db")
    c = conn.cursor()
    c.execute('''SELECT userid, username, fullname, biography 
                 FROM userin 
                 WHERE username LIKE ? OR fullname LIKE ? OR biography LIKE ? 
                 LIMIT 100''',
              (f"%{keyword}%", f"%{keyword}%", f"%{keyword}%"))
    results = [{"userid": row[0], "username": row[1], "fullname": row[2], "biography": row[3]} for row in c.fetchall()]
    conn.close()
    return {"results": results}