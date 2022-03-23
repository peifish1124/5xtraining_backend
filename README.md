# 5xtraining_backend 任務管理系統
## 開發環境
* Ruby 版本 3.0.0
* Rails 版本 7.0.2.3
* 資料庫: PostgreSQL
* 網站部署: Heroku
* 自動化測試: GitHub Action CI
## table schema
![5xtraining_table drawio (1)](https://user-images.githubusercontent.com/58721888/158300655-3190d7af-9605-4b62-bdf4-8c34b5944812.png)
## Heroku 部署
*  申請 Heroku 帳號
*  安裝 Heroku Cli
     https://devcenter.heroku.com/articles/heroku-cli
* 登入 Heroku，輸入剛申請的帳號密碼。
  ```
  $ heroku login
  ```
* 創建一個新的 Heroku 應用
  ```
  $ heroku create
  ```
* 把專案推上 Heroku
  ```
  $ git push heroku main
  ```
* 用  Heroku 執行 rails db:migrate
  ```
  $ heroku run rails db:migrate
  ```
* 網址：https://sleepy-woodland-51841.herokuapp.com/
