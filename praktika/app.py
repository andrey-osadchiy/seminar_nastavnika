import streamlit as st
import requests
import pandas as pd
import json
from io import StringIO

st.title("Поиск по профилям пользователей")

keyword = st.text_input("Введите ключевое слово:", key="keyword")
if st.button("Поиск"):
    if keyword:
        with st.spinner("Выполняется поиск..."):
            try:
                response = requests.post("http://fastapi:8000/search", json={"keyword": keyword})
                response.raise_for_status()
                results = response.json().get("results", [])
                if results:
                    df = pd.DataFrame(results)
                    st.table(df[["userid", "username", "fullname", "biography"]])
                    
                    json_str = json.dumps(results, ensure_ascii=False, indent=2)
                    json_bytes = StringIO(json_str).read().encode('utf-8')
                    
                    st.download_button(
                        label="Скачать результаты в JSON",
                        data=json_bytes,
                        file_name="search_results.json",
                        mime="application/json"
                    )
                else:
                    st.warning("Ничего не найдено")
            except requests.RequestException as e:
                st.error(f"Ошибка связи с сервером: {e}")
    else:
        st.error("Введите ключевое слово")