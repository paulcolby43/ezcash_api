# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_10_135234) do

  create_table "ACHLog", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.datetime "CreateDate"
    t.integer "NumItems"
    t.money "Total", precision: 19, scale: 4
    t.text_basic "Report"
    t.integer "IsClubCSV", limit: 1
    t.integer "event_id"
  end

  create_table "ACHReversals", id: false, force: :cascade do |t|
    t.integer "ACHReportID", null: false
    t.integer "ActID", null: false
  end

  create_table "AccountTypes", primary_key: "AccountTypeID", id: :integer, force: :cascade do |t|
    t.varchar "AccountTypeDesc", limit: 50
    t.datetime "LockDate"
    t.string "LockUser", limit: 50
    t.integer "AddFlag", limit: 1
    t.integer "MoveFlag", limit: 1
    t.integer "DepositFlag", limit: 1
    t.string "AddPriTranCode", limit: 4, default: "ERR"
    t.string "AddTranDesc", limit: 50
    t.nchar "AddTranIcon", limit: 1000
    t.string "MovePriTranCode", limit: 4, default: "ERR"
    t.string "MoveTranDesc", limit: 50
    t.nchar "MoveTranIcon", limit: 1000
    t.nchar "AddBalEff", limit: 2, default: "0 "
    t.nchar "AddFeeEff", limit: 2, default: "0 "
    t.nchar "MoveBalEff", limit: 2, default: "0 "
    t.nchar "MoveFeeEff", limit: 2, default: "0 "
    t.varchar "AddSecTranCode", limit: 4
    t.varchar "MoveSecTranCode", limit: 5
    t.integer "DescLangObjID"
    t.integer "AuxTextObjID"
    t.integer "CompanyNumber", default: 0, null: false
    t.integer "CanFundByACH", limit: 1
    t.integer "CanFundByCC", limit: 1
    t.integer "CanFundByCash", limit: 1
    t.integer "CanWithdraw", limit: 1
    t.integer "CanPull", limit: 1
    t.integer "CanRequestPmtBySearch", limit: 1
    t.integer "CanRequestPmtByScan", limit: 1
    t.integer "CurrencyType"
    t.integer "CanSendPmt", limit: 1
    t.integer "WithdrawAll", limit: 1
    t.integer "CanBePulledBySearch", limit: 1
    t.integer "CanBePulledByScan", limit: 1
    t.money "MinMaintainBal", precision: 19, scale: 4
    t.float "MinBalPercent"
    t.money "MinBalMax", precision: 19, scale: 4
    t.money "DefaultMinBal", precision: 19, scale: 4
    t.integer "CanBePushedByScan", limit: 1
    t.integer "contract_id"
    t.integer "date_of_birth_required", limit: 1
    t.integer "social_security_number_required", limit: 1
    t.integer "clear_balances_bill_externally", limit: 1
    t.integer "hide_pull_payment_from_holder", limit: 1
    t.varchar "bill_code", limit: 50
    t.integer "CorpAcctFlag", limit: 1
    t.money "single_withdrawal_limit", precision: 19, scale: 4
    t.money "daily_withdrawal_limit", precision: 19, scale: 4
    t.money "single_transfer_limit", precision: 19, scale: 4
    t.money "daily_transfer_limit", precision: 19, scale: 4
  end

  create_table "Accounts", primary_key: "ActID", id: :integer, force: :cascade do |t|
    t.integer "CustomerID"
    t.integer "CompanyNumber"
    t.integer "EntityID"
    t.integer "ActTypeID"
    t.string "ActNbr", limit: 50
    t.money "Balance", precision: 19, scale: 4, default: 0.0
    t.string "ButtonText", limit: 50
    t.integer "AddIndex", default: 0
    t.integer "AddFlag", limit: 1, default: 0
    t.money "AddFee", precision: 19, scale: 4, default: 0.0
    t.integer "MoveIndex", default: 0
    t.integer "MoveFlag", limit: 1, default: 0
    t.money "MoveFee", precision: 19, scale: 4, default: 0.0
    t.integer "DepositFlag", limit: 1, default: 0
    t.datetime "CreateDate", default: -> { "getdate()" }
    t.varchar "CreateUser", limit: 40
    t.datetime "ModifiedDate"
    t.varchar "ModifiedUser", limit: 40
    t.datetime "LockDate"
    t.varchar "LockUser", limit: 40
    t.integer "AddGroupID"
    t.integer "MoveGroupID"
    t.integer "AddParentID"
    t.integer "MoveParentID"
    t.string "AuxText", limit: 500
    t.integer "Active", limit: 1, default: 1
    t.integer "AbleToDelete", limit: 1, default: 1
    t.integer "IsBankAccount", limit: 1, default: 0
    t.integer "AbleToACH", limit: 1
    t.string "SecurityCode", limit: 50
    t.string "ExpDate", limit: 50
    t.integer "IsPayeeAccount", limit: 1
    t.money "MinBalance", precision: 19, scale: 4, default: 0.0
    t.integer "IssuingCompanyNumber"
    t.varchar "BankActNbr", limit: 50
    t.varchar "RoutingNbr", limit: 50
    t.integer "SMSOnCredit", limit: 1
    t.integer "SMSOnDebit", limit: 1
    t.money "MaintainBal", precision: 19, scale: 4
    t.datetime "LastACHDate", default: '01-01-1900 00:00:00.0'
  end

  create_table "AuthBinRange", primary_key: ["BinLow", "BinHigh"], force: :cascade do |t|
    t.varchar "AuthID", limit: 50
    t.varchar "BinLow", limit: 16, null: false
    t.varchar "BinHigh", limit: 16, null: false
    t.integer "OnUs", limit: 1
  end

  create_table "Authorizers", primary_key: "AuthID", id: { type: :varchar, limit: 10 }, force: :cascade do |t|
    t.varchar "Description", limit: 100
    t.varchar "HostName", limit: 50
    t.integer "PortNbr"
    t.char "HeaderType", limit: 1
    t.integer "HeaderLen"
    t.char "HeaderOrder", limit: 1
    t.integer "DefaultFlag"
  end

  create_table "CameraTypes", id: false, force: :cascade do |t|
    t.integer "CameraType", null: false
    t.varchar "Description", limit: 50
  end

  create_table "Companies", primary_key: "CompanyNumber", id: :integer, force: :cascade do |t|
    t.string "CompanyName", limit: 50
    t.datetime "CreateDate", default: -> { "getdate()" }
    t.varchar "CreateUser", limit: 40
    t.datetime "ModifiedDate"
    t.varchar "ModifiedUser", limit: 40
    t.integer "EntityID"
    t.integer "Tier"
    t.integer "BackgroundCheck"
    t.integer "CustomerActivation"
    t.integer "USorForeignPhotoID"
    t.integer "USPhotoID"
    t.integer "Active"
    t.integer "DefaultCustGroupID"
    t.integer "CardID"
    t.varchar "ACH_Bank_Name", limit: 100
    t.varchar "ACH_Company_ID", limit: 50
    t.varchar "ACH_Company_Name", limit: 100
    t.varchar "ACH_Company_Short_Name", limit: 50
    t.varchar "ACH_User_ID", limit: 50
    t.integer "transaction_fee_cents"
    t.integer "payee_can_edit_payment"
    t.integer "include_tip"
    t.varchar "reply_to_emails", limit: 255
    t.integer "include_rounds", limit: 1
    t.integer "FeeActID"
    t.integer "TxnActID"
    t.integer "CashierActID"
    t.integer "can_quick_pay", limit: 1
    t.integer "quick_pay_account_type_id"
  end

  create_table "CompanyAccounts", primary_key: ["CompanyNbr", "PriTranCode", "SecTranCode"], force: :cascade do |t|
    t.integer "CompanyNbr", null: false
    t.varchar "PriTranCode", limit: 10, null: false
    t.varchar "SecTranCode", limit: 10, null: false
    t.integer "ActID"
  end

  create_table "CompanyActDefaultMinBal", id: false, force: :cascade do |t|
    t.integer "CompanyNumber"
    t.integer "AccountTypeID"
    t.money "DefaultMinBal", precision: 19, scale: 4
  end

  create_table "CurrencySpecs", id: false, force: :cascade do |t|
    t.integer "currency_type"
    t.money "denom", precision: 19, scale: 4
    t.integer "fuji_length"
    t.integer "fuji_thickness"
    t.integer "denomination"
    t.integer "fuji_width"
  end

  create_table "Customer", primary_key: "CustomerID", id: :integer, force: :cascade do |t|
    t.integer "ParentCustID"
    t.string "Tier", limit: 50
    t.datetime "CreateDate", default: -> { "getdate()" }
    t.varchar "CreateUser", limit: 40
    t.datetime "ModifiedDate"
    t.varchar "ModifiedUser", limit: 40
    t.datetime "LockDate"
    t.varchar "LockUser", limit: 40
    t.integer "Active", default: 1
    t.boolean "TranActive", default: false, null: false
    t.datetime "LastTranLogDate"
    t.integer "CompanyNumber", default: 0
    t.integer "DefaultAccount"
    t.integer "AddPrimaryAccount"
    t.integer "StartOnMoveScreen"
    t.integer "LangID"
    t.varchar "user_name", limit: 40
    t.string "pwd_hash", limit: 50
    t.string "NameF", limit: 50
    t.string "NameM", limit: 50
    t.string "NameL", limit: 50
    t.string "NameS", limit: 50
    t.integer "user_pin", limit: 2
    t.string "user_salt", limit: 50
    t.integer "UserLoggedIn", limit: 1
    t.datetime "UserLastLogin"
    t.integer "PasswordExpired", limit: 1
    t.string "Email", limit: 50
    t.string "AddressL1", limit: 50
    t.string "AddressL2", limit: 50
    t.string "City", limit: 50
    t.string "State", limit: 20
    t.nchar "Zip", limit: 20
    t.string "PhoneHome", limit: 50
    t.string "PhoneWork", limit: 50
    t.string "PhoneMobile", limit: 50
    t.string "SSN", limit: 50
    t.datetime "DOB"
    t.string "Occupation", limit: 50
    t.string "Race", limit: 50
    t.string "County", limit: 50
    t.string "Registration_Source", limit: 50
    t.varchar "Registration_Source_ext", limit: 50
    t.string "Background_CK_Flag", limit: 50
    t.string "Registration_Flag", limit: 50
    t.varchar "FingerMatch", limit: 1
    t.integer "LostCardCode"
    t.integer "Customer_ACK", limit: 1
    t.integer "MessageSMS", limit: 1
    t.integer "MessageEmail", limit: 1
    t.integer "MessageLetter", limit: 1
    t.integer "pwd_needs_change"
    t.integer "GroupID"
    t.integer "CurrentPhotoIDID"
    t.integer "PrimaryACHActID"
    t.integer "IsTempUserName", limit: 1
    t.integer "IsTempPassword", limit: 1
    t.integer "LangObjID1"
    t.string "Answer1", limit: 50
    t.integer "LangObjID2"
    t.string "Answer2", limit: 50
    t.char "Sex", limit: 1
    t.varchar "Height", limit: 5
    t.varchar "Weight", limit: 10
    t.varchar "EyeColor", limit: 10
    t.varchar "HairColor", limit: 10
    t.string "LangObjID3", limit: 50
    t.string "Answer3", limit: 50
    t.string "CustomQuestion1", limit: 50
    t.string "CustomQuestion2", limit: 50
    t.string "CustomQuestion3", limit: 50
    t.varchar "ReviewNeeded", limit: 5
    t.integer "CKtimeout"
    t.integer "MoneyTransferFlag", limit: 1
    t.varchar "Country", limit: 2
    t.integer "CKActive", default: 1
    t.float "wdl_fee"
    t.integer "flat_fee_flag", limit: 1
    t.varchar "avatar", limit: 255
    t.varchar "barcode_access_string", limit: 255
    t.index ["user_name"], name: "NonClusteredIndex-20130305-084332"
  end

  create_table "CustomerAccountPermission", primary_key: ["GroupID", "CustomerID"], force: :cascade do |t|
    t.integer "GroupID", null: false
    t.integer "CustomerID", null: false
    t.integer "IsMakeHotCard", limit: 1, null: false
    t.integer "IsViewCardType", limit: 1, null: false
    t.integer "IsEditCardType", limit: 1, null: false
  end

  create_table "CustomerBarcode", primary_key: "RowID", id: :integer, force: :cascade do |t|
    t.integer "CustomerID"
    t.datetime "date_time"
    t.integer "CompanyNumber"
    t.varchar "Barcode", limit: 20
    t.integer "TranID"
    t.integer "Used", limit: 1
    t.money "amount", precision: 19, scale: 4
    t.integer "ActID"
    t.integer "DevID"
  end

  create_table "CustomerCards", primary_key: "CardID", id: :integer, force: :cascade do |t|
    t.integer "CustomerID"
    t.string "PAN", limit: 50
    t.string "CDType", limit: 50
    t.integer "Loadable", limit: 1
    t.integer "ActID"
    t.integer "CompanyNumber"
    t.datetime "CreateDate"
    t.datetime "ResetDate"
    t.varchar "pin_offset", limit: 50
  end

  create_table "DevTypes", primary_key: "DevType", id: :integer, default: nil, force: :cascade do |t|
    t.varchar "description", limit: 80
  end

  create_table "EZPermissionDesc", primary_key: "PermissionID", id: :integer, default: nil, force: :cascade do |t|
    t.varchar "Description", limit: 50
  end

  create_table "Entities", primary_key: "EntityID", id: :integer, force: :cascade do |t|
    t.string "EntityName", limit: 50
    t.string "EntityAddressL1", limit: 50
    t.string "EntityAddressL2", limit: 50
    t.string "EntityCity", limit: 50
    t.string "EntityState", limit: 50
    t.nchar "EntityZip", limit: 20
    t.string "EntityPhone", limit: 15
    t.string "EntityContactName", limit: 50
    t.string "EntityContactPhone", limit: 15
    t.datetime "CreateDate", default: -> { "getdate()" }
    t.varchar "CreateUser", limit: 40
    t.datetime "ModifiedDate"
    t.varchar "ModifiedUser", limit: 40
    t.datetime "LockDate"
    t.varchar "LockUser", limit: 40
    t.integer "Active", limit: 1, default: 1
    t.integer "DestCardID"
    t.integer "OwningCustomerID"
    t.integer "DestActID", default: 0
    t.string "EntityCountry", limit: 50
  end

  create_table "EntityAccountTypes", primary_key: ["EntityID", "AccountTypeID"], force: :cascade do |t|
    t.integer "EntityID", null: false
    t.integer "AccountTypeID", null: false
    t.nchar "RoutingNbr", limit: 20
    t.nchar "AccountNbr", limit: 40
    t.string "BankName", limit: 50
    t.string "BankAddressL1", limit: 50
    t.string "BankAddressL2", limit: 50
    t.string "BankCity", limit: 50
    t.string "BankState", limit: 50
    t.nchar "BankZip", limit: 20
    t.datetime "CreateDate", default: -> { "getdate()" }
    t.varchar "CreateUser", limit: 40
    t.datetime "ModifiedDate"
    t.varchar "ModifiedUser", limit: 40
    t.datetime "LockDate"
    t.varchar "LockUser", limit: 40
    t.integer "Active", limit: 1, default: 1
    t.string "BankCountry", limit: 50
    t.integer "PaymentMethod"
  end

  create_table "FeeDefs", primary_key: "FeeID", id: :integer, force: :cascade do |t|
    t.varchar "Filter", limit: 500
    t.varchar "TheFee", limit: 100
    t.varchar "Description", limit: 100
    t.integer "GLMod"
    t.integer "CreditsCust"
  end

  create_table "FieldDescriptions", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "TableName", limit: 50
    t.varchar "FieldName", limit: 50
    t.varchar "FieldDescription", limit: 500
  end

  create_table "Fields", primary_key: ["ScreenID", "FieldID"], force: :cascade do |t|
    t.integer "ScreenID", null: false
    t.integer "FieldID", null: false
    t.string "FieldName", limit: 50
    t.string "FieldDescription", limit: 100
    t.integer "Active", limit: 1, default: 1
  end

  create_table "Groups", primary_key: "GroupID", id: :integer, force: :cascade do |t|
    t.string "GroupDescription", limit: 50
    t.integer "Active", limit: 1, default: 1
    t.integer "ParentGroupID"
    t.boolean "IsCustomer", default: false
    t.integer "AddPrimaryAccount"
    t.integer "StartOnMoveScreen"
    t.integer "IsViewPayeeSection", limit: 1
  end

  create_table "Interfaces", primary_key: "InterfaceID", id: { type: :varchar, limit: 10 }, force: :cascade do |t|
    t.varchar "Description", limit: 100
    t.varchar "HostName", limit: 50
    t.integer "PortNbr"
    t.char "HeaderType", limit: 1
    t.integer "HeaderLen"
    t.char "HeaderOrder", limit: 1
    t.integer "DefaultFlag"
    t.integer "InterfaceType"
    t.integer "IsTCPClient"
  end

  create_table "LimitBuckets", primary_key: ["LimitID", "BucketOrder"], force: :cascade do |t|
    t.integer "LimitID", null: false
    t.varchar "Location", limit: 50
    t.varchar "KeyFields", limit: 50
    t.varchar "ResetTo", limit: 50
    t.varchar "ResetWhere", limit: 50
    t.integer "IsInformix", limit: 1
    t.integer "BucketOrder", null: false
    t.float "CycleLengthDays"
    t.integer "MidnightFlag", limit: 1
    t.integer "ResetFlag", limit: 1
    t.integer "IsCredit", limit: 1
    t.varchar "LastActivityField", limit: 50
  end

  create_table "Limits", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 150
    t.integer "LimitOrder"
    t.varchar "Filter", limit: 500
    t.varchar "WhereClause", limit: 500
    t.money "Amount", precision: 19, scale: 4
    t.float "TimeLimitDays"
    t.integer "MidnightFlag", limit: 1
    t.varchar "AggregateFunction", limit: 50
    t.varchar "CompareExpr", limit: 50
    t.integer "Disabled", limit: 1
  end

  create_table "OpCodesMap", primary_key: "KeySeq", id: { type: :varchar, limit: 20 }, force: :cascade do |t|
    t.varchar "TranCode", limit: 10
    t.integer "CassetteID"
    t.varchar "SwxPriTran", limit: 50
    t.varchar "SwxSecTran", limit: 50
    t.varchar "SwxSecRev", limit: 50
  end

  create_table "RoleDescription", primary_key: "RoleID", id: :integer, default: nil, force: :cascade do |t|
    t.varchar "RoleDescription", limit: 50, null: false
  end

  create_table "RolePermissions", primary_key: ["RoleID", "PermissionID"], force: :cascade do |t|
    t.integer "RoleID", null: false
    t.integer "PermissionID", null: false
    t.integer "Enabled"
  end

  create_table "SMSLog", id: false, force: :cascade do |t|
    t.datetime "Timestamp"
    t.varchar "MobileNbr", limit: 50
    t.varchar "Message", limit: 500
    t.integer "CompanyNbr"
    t.varchar "Result", limit: 5000
  end

  create_table "SystemSettings", primary_key: "Setting", id: { type: :varchar, limit: 50 }, force: :cascade do |t|
    t.varchar "Value", limit: 100, null: false
    t.varchar "Description", limit: 200
  end

  create_table "TUDUserAuth", id: false, force: :cascade do |t|
    t.varchar "UserName", limit: 50, null: false
    t.varchar "UserHash", limit: 50, null: false
  end

  create_table "TransactionTypes", primary_key: "TransactionTypeID", id: :integer, force: :cascade do |t|
    t.varchar "PrimaryTranCode", limit: 10
    t.varchar "SecondaryTranCode", limit: 10
    t.varchar "Description", limit: 500
    t.varchar "Description2", limit: 500
    t.varchar "Acct1Icon", limit: 50
    t.varchar "Acct2Icon", limit: 50
    t.integer "CustIsDest"
  end

  create_table "Workstation_Device", primary_key: "WorkstationID", id: :integer, default: nil, force: :cascade do |t|
    t.integer "PinPadID"
    t.integer "ATMDevID"
    t.integer "CompanyNbr"
    t.varchar "IPAddr", limit: 50
    t.integer "OwningEntityID"
    t.integer "ChkCashCompanyNbr"
    t.integer "OwningCompanyNbr"
  end

  create_table "accounts_events", primary_key: ["account_id", "event_id"], force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "event_id", null: false
    t.index ["account_id", "event_id"], name: "NonClusteredIndex-20190218-115935", unique: true
  end

  create_table "auth_params", id: false, force: :cascade do |t|
    t.varchar "param_name", limit: 20, null: false
    t.varchar "description", limit: 80
    t.integer "active_flag"
    t.integer "dev_id", null: false
    t.varchar "val1_desc", limit: 40
    t.float "val1"
    t.varchar "val2_desc", limit: 40
    t.float "val2"
    t.varchar "val3_desc", limit: 40
    t.float "val3"
    t.integer "clone_flag"
  end

  create_table "bill_counts", id: false, force: :cascade do |t|
    t.integer "host_start_count"
    t.integer "host_cycle_count"
    t.integer "dev_start_count"
    t.integer "dev_cycle_count"
    t.integer "dev_divert_count"
    t.integer "added_count"
    t.integer "old_added"
    t.integer "dev_id"
    t.integer "cassette_nbr"
    t.varchar "cassette_id", limit: 10
    t.integer "status"
    t.index ["dev_id", "cassette_id"], name: "bill_counts_pri", unique: true
  end

  create_table "bill_hist", id: false, force: :cascade do |t|
    t.datetime "cut_dt"
    t.integer "old_start"
    t.integer "old_term_cyc"
    t.integer "old_host_cyc"
    t.integer "added"
    t.integer "replaced"
    t.integer "new_start"
    t.varchar "cassette_id", limit: 10
    t.integer "dev_id"
    t.integer "old_added"
    t.varchar "user_name", limit: 25
    t.float "denomination"
    t.index ["cut_dt"], name: "bill_hist_dt"
  end

  create_table "card_field_desc", primary_key: "field_name", id: { type: :varchar, limit: 30 }, force: :cascade do |t|
    t.varchar "short_desc", limit: 15
  end

  create_table "cards", primary_key: "card_seq", id: :integer, force: :cascade do |t|
    t.decimal "bank_id_nbr", precision: 12, scale: 2, null: false
    t.varchar "card_nbr", limit: 25, null: false
    t.integer "dev_id"
    t.decimal "card_amt", precision: 12, scale: 2
    t.decimal "avail_amt", precision: 12, scale: 2
    t.char "card_status", limit: 2
    t.datetime "issued_date"
    t.datetime "last_activity_date"
    t.varchar "receipt_nbr", limit: 25
    t.varchar "barcodeHash", limit: 32
    t.varchar "bank_code", limit: 10
    t.integer "cust_id"
    t.integer "tran_id"
    t.nchar "IssuingCompanyNbr", limit: 20
    t.index ["avail_amt"], name: "cards_avail"
    t.index ["barcodeHash"], name: "cards_hash"
    t.index ["card_nbr"], name: "cards_card"
    t.index ["issued_date"], name: "cards_issued"
  end

  create_table "change_log", id: false, force: :cascade do |t|
    t.varchar "user_name", limit: 40
    t.datetime "change_time"
    t.char "change_type", limit: 1
    t.varchar "table_name", limit: 20
    t.varchar "field_name", limit: 20
    t.varchar "old_value", limit: 100
    t.varchar "new_value", limit: 100
  end

  create_table "denoms", primary_key: ["dev_id", "cassette_id"], force: :cascade do |t|
    t.float "denomination"
    t.integer "dev_id", null: false
    t.integer "cassette_nbr"
    t.varchar "cassette_id", limit: 10, null: false
    t.integer "currency_type"
    t.index ["dev_id", "cassette_id"], name: "denoms_pri", unique: true
  end

  create_table "dev_statuses", id: false, force: :cascade do |t|
    t.integer "dev_id"
    t.datetime "date_time"
    t.char "status", limit: 4
    t.varchar "raw_status", limit: 80
    t.index ["dev_id", "date_time"], name: "dev_status_dt"
  end

  create_table "devices", primary_key: "dev_id", id: :integer, default: nil, force: :cascade do |t|
    t.integer "online"
    t.varchar "description", limit: 40
    t.varchar "address", limit: 100
    t.varchar "encryption_key", limit: 16
    t.varchar "welcome1", limit: 80
    t.varchar "welcome2", limit: 80
    t.varchar "jpg_bank_code", limit: 10
    t.varchar "load_file", limit: 30
    t.varchar "receipt_file", limit: 30
    t.varchar "ip_address", limit: 50
    t.integer "coin_dev_id"
    t.varchar "camera_group", limit: 30
    t.integer "use_jpegger"
    t.varchar "jpegger_addr", limit: 30
    t.integer "jpegger_port"
    t.varchar "jpegger_location", limit: 25
    t.integer "retries"
    t.integer "round_to"
    t.integer "round_method"
    t.decimal "maxcoin", precision: 5, scale: 2
    t.varchar "fitness", limit: 100
    t.datetime "fitness_dt"
    t.varchar "config", limit: 100
    t.datetime "config_dt"
    t.varchar "supplies", limit: 100
    t.datetime "supplies_dt"
    t.integer "comm_port"
    t.integer "baud_rate"
    t.integer "advanced_ndc"
    t.integer "caution_flag"
    t.char "caution_status", limit: 4
    t.varchar "monitor_group", limit: 20
    t.varchar "monitor_site", limit: 20
    t.varchar "dev_group", limit: 20
    t.varchar "dev_site", limit: 20
    t.integer "bills_in_bundle"
    t.integer "TranID"
    t.integer "DispenseByAmtFlag"
    t.varchar "TMK_LMK", limit: 50
    t.varchar "TPK_LMK", limit: 50
    t.integer "PINEnabled"
    t.integer "inactive_flag"
    t.integer "CompanyNbr"
    t.integer "VendorID"
    t.integer "InstitutionID"
    t.varchar "VendorPAN", limit: 20
    t.varchar "BDK_LMK", limit: 50
    t.integer "uses_DUKPT", limit: 1
    t.integer "dev_typeID"
    t.integer "isTCPClient"
    t.integer "PortNbr"
    t.boolean "edge_atm"
    t.integer "OwningEntityID"
    t.integer "CanAcquire", limit: 1
    t.integer "ChkCashCompanyNbr"
    t.integer "ReviewVerification", limit: 1
    t.integer "num_images"
    t.integer "capture_interval"
    t.integer "image_interval"
    t.varchar "yardid", limit: 50
    t.integer "LocCompanyNbr"
    t.varchar "payment_type", limit: 50
  end

  create_table "error_desc", primary_key: "error_code", id: :integer, default: nil, force: :cascade do |t|
    t.varchar "short_desc", limit: 80
    t.varchar "long_desc", limit: 500
  end

  create_table "events", id: :integer, force: :cascade do |t|
    t.integer "company_id"
    t.varchar "title", limit: 255, null: false
    t.string "start_date", limit: 10
    t.string "end_date", limit: 10
    t.varchar "join_code", limit: 255
    t.ntext "join_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expire_accounts"
    t.integer "account_type_id"
    t.boolean "join_active_status"
  end

  create_table "password_rules", id: false, force: :cascade do |t|
    t.integer "pwd_expires_days"
  end

  create_table "status_desc", primary_key: "status", id: { type: :char, limit: 4 }, force: :cascade do |t|
    t.varchar "short_desc", limit: 80
    t.integer "caution_flag"
    t.integer "alert_flag"
  end

  create_table "tran_field_desc", primary_key: "field_name", id: { type: :varchar, limit: 30 }, force: :cascade do |t|
    t.varchar "short_desc", limit: 15
    t.integer "only_cust_tran", limit: 1
  end

  create_table "tran_status_desc", primary_key: "tran_status", id: :integer, default: nil, force: :cascade do |t|
    t.varchar "short_desc", limit: 80
    t.varchar "long_desc", limit: 255
    t.nchar "icon", limit: 500
  end

  create_table "transactions", primary_key: "tranID", id: :integer, force: :cascade do |t|
    t.datetime "date_time", default: -> { "getdate()" }
    t.integer "dev_id"
    t.integer "FromCustID"
    t.integer "ToCustID"
    t.integer "tran_status"
    t.integer "error_code"
    t.char "tran_code", limit: 4
    t.varchar "card_nbr", limit: 25
    t.varchar "receipt_nbr", limit: 25
    t.decimal "amt_req", precision: 12, scale: 2
    t.decimal "amt_auth", precision: 12, scale: 2
    t.integer "cassette_1_disp"
    t.integer "cassette_2_disp"
    t.integer "cassette_3_disp"
    t.integer "cassette_4_disp"
    t.integer "cassette_5_disp"
    t.integer "cassette_6_disp"
    t.varchar "track2", limit: 50
    t.decimal "bank_id_nbr", precision: 12, scale: 2
    t.decimal "coin_disp", precision: 5, scale: 2
    t.integer "coin_1_disp"
    t.integer "coin_2_disp"
    t.integer "coin_3_disp"
    t.integer "coin_4_disp"
    t.integer "coin_5_disp"
    t.integer "coin_6_disp"
    t.money "cashBalance", precision: 19, scale: 4
    t.integer "ActID"
    t.datetime "CreateDate", default: -> { "getdate()" }
    t.varchar "CreateUser", limit: 40
    t.datetime "ModifiedDate"
    t.varchar "ModifiedUser", limit: 40
    t.integer "card_seq"
    t.integer "from_acct_id"
    t.integer "from_acct_type"
    t.integer "to_acct_id"
    t.integer "to_acct_type"
    t.char "authID", limit: 4
    t.char "sec_tran_code", limit: 4
    t.integer "BlockID"
    t.integer "AddFlag", limit: 1
    t.integer "MoveFlag", limit: 1
    t.varchar "Description", limit: 50
    t.money "ChpFee", precision: 19, scale: 4
    t.integer "DevCompanyNbr"
    t.integer "IssuingCompanyNbr"
    t.varchar "BarcodeHash", limit: 50
    t.integer "CheckCategoryID"
    t.integer "FeedActID"
    t.integer "OrigTranID"
    t.varchar "from_acct_nbr", limit: 20
    t.varchar "to_acct_nbr", limit: 20
    t.varchar "Note", limit: 200
    t.integer "FailedLimitID"
    t.varchar "external_ref_nbr", limit: 50
    t.varchar "upload_file", limit: 255
    t.integer "event_id"
    t.varchar "dev_address", limit: 100
    t.integer "custID"
    t.integer "user_id"
    t.index ["BlockID"], name: "transactions_block"
    t.index ["OrigTranID"], name: "i_OrigTranID"
    t.index ["date_time"], name: "i_date_time"
    t.index ["tranID"], name: "transactions_seq", unique: true
  end

  create_table "user_roles", primary_key: "user_name", id: { type: :varchar, limit: 40 }, force: :cascade do |t|
    t.varchar "pwd_hash", limit: 40
    t.integer "user_role_index"
    t.integer "pwd_needs_change"
    t.datetime "pwd_last_changed"
    t.integer "win_auth"
    t.varchar "dev_group", limit: 20
    t.varchar "dev_site", limit: 20
    t.integer "disable_add"
    t.varchar "api_auth_token", limit: 255
    t.integer "company_id"
  end

  add_foreign_key "Accounts", "Companies", column: "CompanyNumber", primary_key: "CompanyNumber", name: "FK_Accounts_Companies"
  add_foreign_key "Companies", "Groups", column: "DefaultCustGroupID", primary_key: "GroupID", name: "FK_Companies_DefGrp"
  add_foreign_key "Customer", "Accounts", column: "DefaultAccount", primary_key: "ActID", name: "FK_Customer_Accounts"
  add_foreign_key "Customer", "Companies", column: "CompanyNumber", primary_key: "CompanyNumber", name: "FK_Customer_Companies"
  add_foreign_key "Customer", "Customer", column: "ParentCustID", primary_key: "CustomerID", name: "FK_Customer_Customer"
  add_foreign_key "Customer", "Groups", column: "GroupID", primary_key: "GroupID", name: "FK_Customer_Groups"
end
