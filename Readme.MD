# This Repository contains a bunch of small CLI tools
Currently this is written for Macos so some tools might depend on things like the `open` command.

# Instalation
Installation assumes you are using zsh, if different modify script first.

```bash
brew install fzf
echo 'export PATH="$(pwd)/scripts:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

# Tools
## `fzurl` - A Fuzzy Search URL Opener

`fz` is a shell script that lets you open / generate URLs based on fzf's fuzzy searching and multiselection.


### Usage

```bash
fz [OPTIONS] [REPLACEMENT_ARG]
```

#### Default urls
```csv
Google Search,https://www.google.com/search?q=%s
DuckDuckGo Search,https://duckduckgo.com/?q=%s

Coinmarketcap Crypto Price,https://coinmarketcap.com/currencies/%s
Binance Crypto Price,https://www.binance.com/en/price/%s
```

#### Default arguments
```csv
Crypto Bitcoin BTC,bitcoin
Crypto Ethereum ETH,ethereum
```
#### Example 1

Open multiple crypto prices on multiple exchanges:
`fz`
This will load the default urls config file, and pass its config to fzf to search and select.

Type crypto and hit `tab` twice.
This will select coinmarketcap and binance, then hit `enter`.
This will load the arguments file, use the arrow keys or searching to select values using `tab` again.
Once you hit enter a combination of each URL replacement and argument will be made and those will be passed as arguments to the open command.

#### Example 2
Search for a string on multiple search engines
`fz "amazing search term"`

This will open fzf fuzzy search of the default urls, typing search based on the example config should display google and duckduckgo. Hitting `tab` twice should select them both, then hitting enter should open
```
https://google.com/search?q=amazing search
https://duckduckgo.com/?q=amazing search
```

#### Example 3
default_arguments.csv

```csv
Servicenow Table USER,sys_user
Servicenow Table db,sys_db_object
Servicenow Table scriptinclude,sys_script_include
Servicenow Table businessrule,sys_script
```

Now to make it easy to open the list for any ServiceNow table in the arguments csv.
```
alias snl=fz --url="https://someinstance.service-now.com/%s_list.do"
```

if you type snl, you can fuzzy search through the arguments for example type user, then hit enter and the user list will be opened.



### Options
--runner=EXECUTABLE : Set the program to open the URLs (default is open).

--url=URL : Use a single URL.

--urlsfile=FILE : Use a file with a list of URLs.

--argsfile=FILE : Use a CSV file containing name-argument pairs.

--create-defaults : Create default URL and CSV files if they do not exist.

--help : Display the help message.

### Replacement Argument
REPLACEMENT_ARG: A single argument to replace the %s placeholder in the URLs.

### Dependencies
fzf: A command-line fuzzy finder. Make sure fzf is installed and available in your system's PATH.
https://github.com/junegunn/fzf

### Configuration Files
URLs File: Default at ~/default_urls.csv (or your specified file).

Arguments File: Default at ~/default_arguments.csv (or your specified file).
