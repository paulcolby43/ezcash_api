# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    # Accounts
      ############
      can :manage, Account do |account|
        user.company == account.company
      end
      can :create, Account
    
    # AccountTypes
      ############
      can :manage, AccountType do |account_type|
        user.company == account_type.company
      end
      can :create, AccountType
      
    # AuthParams
      ############
      can :manage, AuthParam do |auth_param|
        user.company == auth_param.company
      end
      can :create, AuthParam
      
    # BillCounts
      ############
      can :manage, BillCount do |bill_count|
        user.company == bill_count.device.company
      end
      can :create, BillCount
      
    # BillHists
      ############
      can :manage, BillHist do |bill_hist|
        user.company == bill_hist.device.company
      end
      can :create, BillHist
    
    # Companies
      ############
      can :manage, Company do |company|
        user.company == company
      end
      can :create, Company
      cannot :index, Company
      
    # Customers
      ############
      can :manage, Customer do |customer|
        user.company == customer.company
      end
      can :create, Customer
      
    # CustomerBarcodes
      ############
      can :manage, CustomerBarcode do |customer_barcode|
        user.company == customer_barcode.company
      end
      can :create, CustomerBarcode
      
    # Denoms
      ############
      can :manage, Denom do |denom|
        user.company == denom.device.company
      end
      can :create, Denom
      
    # Devices
      ############
      can :manage, Device do |device|
        user.company == device.company
      end
      can :create, Device
      
    # DevStatuses
      ############
      can :manage, DevStatus do |dev_status|
        user.company == dev_status.device.company
      end
      can :create, DevStatus
      
    # OpCodeMaps
      ############
      can :index, OpCodeMap
      
    # RolePermissions
      ############
      can :manage, RolePermission do |role_permission|
        unless role_permission.user.blank?
          user.company == role_permission.user.company
        else
          true
        end
      end
      can :create, RolePermission
      
    # TranStatusDescs
      ############
      can :index, TranStatusDesc
      
    # Transactions
      ############
      can :manage, Transaction do |transaction|
        user.company == transaction.company
      end
      can :create, Transaction
      
    # Users
      ############
      can :manage, User do |this_user|
        user.company == this_user.company
      end
      can :create, User
      
    
    
  end
end
