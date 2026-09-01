import requests
from bs4 import BeautifulSoup
import pandas as pd

# -----------------------------
# STEP 1: Website URL
# -----------------------------
url = "https://books.toscrape.com/"

# -----------------------------
# STEP 2: Request website
# -----------------------------
response = requests.get(url)

if response.status_code != 200:
    print("Website not reachable")
    exit()

# -----------------------------
# STEP 3: Parse HTML
# -----------------------------
soup = BeautifulSoup(response.text, "html.parser")

# -----------------------------
# STEP 4: Find all products
# -----------------------------
products = soup.find_all("article", class_="product_pod")

# -----------------------------
# STEP 5: Extract data
# -----------------------------
data = []

for product in products:
    name = product.h3.a["title"]
    price_text = product.find("p", class_="price_color").text
    rating = product.find("p", class_="star-rating")["class"][1]

    data.append([name, price_text, rating])

# -----------------------------
# STEP 6: Create DataFrame
# -----------------------------
df = pd.DataFrame(data, columns=["Product_Name", "Price", "Rating"])

# -----------------------------
# STEP 7: CLEAN PRICE (IMPORTANT)
# -----------------------------
df["Price"] = (
    df["Price"]
    .astype(str)
    .str.replace("£", "", regex=False)
    .str.replace(",", "", regex=False)
    .str.extract(r"([\d.]+)")
    .astype(float)
)

# -----------------------------
# STEP 8: Save CSV (SAME FOLDER)
# -----------------------------
df.to_csv("scraped_data.csv", index=False)

print("SUCCESS: scraped_data.csv created in same folder")
print(df.head())
