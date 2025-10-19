import os
import json

# Folder name
project_dir = "iris_docker_project"

# Create project folder
os.makedirs(project_dir, exist_ok=True)

# --------------------------
# Dockerfile
# --------------------------
dockerfile_content = """\
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
"""

with open(os.path.join(project_dir, "Dockerfile"), "w") as f:
    f.write(dockerfile_content)

# --------------------------
# requirements.txt
# --------------------------
requirements_content = """\
jupyter
pandas
numpy
scikit-learn
matplotlib
seaborn
"""

with open(os.path.join(project_dir, "requirements.txt"), "w") as f:
    f.write(requirements_content)

# --------------------------
# iris_classification.ipynb
# --------------------------
cells = [
    {
        "cell_type": "markdown",
        "metadata": {},
        "source": [
            "# 🌸 Iris Classification Example\n",
            "This notebook trains a simple classifier on the Iris dataset using Logistic Regression.\n",
            "It also computes accuracy, precision, recall, F1-score, and shows a confusion matrix."
        ]
    },
    {
        "cell_type": "code",
        "metadata": {},
        "execution_count": None,
        "outputs": [],
        "source": [
            "import pandas as pd\n",
            "import numpy as np\n",
            "from sklearn.datasets import load_iris\n",
            "from sklearn.model_selection import train_test_split\n",
            "from sklearn.preprocessing import StandardScaler\n",
            "from sklearn.linear_model import LogisticRegression\n",
            "from sklearn.metrics import (\n",
            "    accuracy_score, precision_score, recall_score, f1_score, confusion_matrix, classification_report\n",
            ")\n",
            "import seaborn as sns\n",
            "import matplotlib.pyplot as plt"
        ]
    },
    {
        "cell_type": "code",
        "metadata": {},
        "execution_count": None,
        "outputs": [],
        "source": [
            "# Load dataset\n",
            "iris = load_iris()\n",
            "X = iris.data\n",
            "y = iris.target\n",
            "\n",
            "# Split dataset\n",
            "X_train, X_test, y_train, y_test = train_test_split(\n",
            "    X, y, test_size=0.3, random_state=42, stratify=y)\n",
            "\n",
            "# Standardize data\n",
            "scaler = StandardScaler()\n",
            "X_train = scaler.fit_transform(X_train)\n",
            "X_test = scaler.transform(X_test)\n",
            "\n",
            "# Train model\n",
            "model = LogisticRegression(max_iter=200)\n",
            "model.fit(X_train, y_train)\n",
            "\n",
            "# Predict\n",
            "y_pred = model.predict(X_test)"
        ]
    },
    {
        "cell_type": "code",
        "metadata": {},
        "execution_count": None,
        "outputs": [],
        "source": [
            "# Calculate metrics\n",
            "acc = accuracy_score(y_test, y_pred)\n",
            "prec = precision_score(y_test, y_pred, average='weighted')\n",
            "rec = recall_score(y_test, y_pred, average='weighted')\n",
            "f1 = f1_score(y_test, y_pred, average='weighted')\n",
            "\n",
            "print('Accuracy:', acc)\n",
            "print('Precision:', prec)\n",
            "print('Recall:', rec)\n",
            "print('F1 Score:', f1)\n",
            "print('\\nClassification Report:\\n', classification_report(y_test, y_pred))"
        ]
    },
    {
        "cell_type": "code",
        "metadata": {},
        "execution_count": None,
        "outputs": [],
        "source": [
            "# Confusion Matrix visualization\n",
            "cm = confusion_matrix(y_test, y_pred)\n",
            "sns.heatmap(cm, annot=True, cmap='Blues', fmt='g',\n",
            "            xticklabels=iris.target_names, yticklabels=iris.target_names)\n",
            "plt.title('Confusion Matrix')\n",
            "plt.xlabel('Predicted')\n",
            "plt.ylabel('Actual')\n",
            "plt.show()"
        ]
    }
]

notebook = {
    "cells": cells,
    "metadata": {
        "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
        },
        "language_info": {
            "name": "python",
            "version": "3.10"
        }
    },
    "nbformat": 4,
    "nbformat_minor": 5
}

# Save the notebook
notebook_path = os.path.join(project_dir, "iris_classification.ipynb")
with open(notebook_path, "w") as f:
    json.dump(notebook, f, indent=2)

# --------------------------
# Done!
# --------------------------
print(f"✅ Project created successfully at: {os.path.abspath(project_dir)}")
print("Next steps:")
print("1️⃣ cd iris_docker_project")
print("2️⃣ docker build -t iris-classifier .")
print("3️⃣ docker run -p 8888:8888 iris-classifier")
print("\nThen open the Jupyter link shown in your terminal.")
