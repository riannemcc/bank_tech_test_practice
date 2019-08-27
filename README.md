## Bank App
### Tech test practice

Steps to use this app:
1. `git clone git@github.com:riannemcc/bank_tech_test_practice.git`
2. `Bundle install` (to install the required gems)
3. `rspec` (to run the unit tests)

For use on the terminal:
1. `irb`
2.  `require './account.rb'`
3. `account = Account.new`
4. `account.credit(100)`
5. `account.debit(20)`
6. `account.statement`

The spec:
You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)
Deposits, withdrawal.
Account statement (date, amount, balance) printing.
Data can be kept in memory (it doesn't need to be stored to a database or anything).

I created a model of the app which I determined would need the following features - credit, debit and statement. I therefore decided to create one class of "Account" with these three features as method names. The statement also required a date feature, however I decided to use the Time.now feature as part of the initialization method. I also initialized an account with a balance of zero.

![Imgur](https://i.imgur.com/stg4GbV.mp4)
