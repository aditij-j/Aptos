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
