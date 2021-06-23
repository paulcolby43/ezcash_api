class CustomerCard < ActiveRecord::Base
  
  ### HABTM Join Table between Customers and Accounts ###
  
  self.primary_key = 'CardID'
  self.table_name= 'CustomerCards'
  
  belongs_to :customer, :foreign_key => "CustomerID", optional: true
  belongs_to :account, :foreign_key => "ActID", optional: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
  
  
end