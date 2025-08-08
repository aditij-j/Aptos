# Recipe Sharing Module

A simple Move language smart contract for sharing and registering unique recipes on the Aptos blockchain.

---

## 📌 Features
- *Initialize Recipe Book* – Create a new recipe book for an account.
- *Submit Recipe* – Add unique recipes identified by their hash.
- *Duplicate Protection* – Prevents submission of the same recipe hash twice.

---

## 🛠 Functions

### init_book(account: &signer)
Initializes a new recipe book for the account.

*Parameters:*
- account: The account that will own the recipe book.

---

### submit_recipe(account: &signer, hash: string::String, title: string::String)
Stores a new recipe in the book.

*Parameters:*
- account: The account submitting the recipe.
- hash: A unique string representing the recipe hash.
- title: The title/name of the recipe.

*Behavior:*
- Checks if the recipe hash already exists.
- If not, stores it in the recipe book.

---

## 💻 Full Code

move
module MyModule::RecipeSharing {
    use std::signer;
    use std::string;
    use aptos_std::table::{Table, new, contains, add};

    /// Resource holding the global recipe registry
    struct RecipeBook has key {
        recipes: Table<string::String, string::String>, // hash => title
    }

    /// Initialize the recipe book
    public fun init_book(account: &signer) {
        let book = RecipeBook {
            recipes: new<string::String, string::String>(),
        };
        move_to(account, book);
    }

    /// Store a unique recipe by hash
    public fun submit_recipe(account: &signer, hash: string::String, title: string::String) acquires RecipeBook {
        let book = borrow_global_mut<RecipeBook>(signer::address_of(account));
        assert!(!contains(&book.recipes, hash), 1);
        add(&mut book.recipes, hash, title);
    }
}


---

## 📋 Usage
1. *Deploy* the module to your Aptos account.
2. *Initialize* your recipe book by calling init_book.
3. *Submit recipes* using submit_recipe with a unique hash.

---

## ⚙ Requirements
- Aptos CLI installed.
- Move language environment setup.

---
<img width="1919" height="889" alt="image" src="https://github.com/user-attachments/assets/b9717ccf-d000-4f67-8579-9d0cac04deba" />

## 📄 License
This project is licensed under the MIT License.
