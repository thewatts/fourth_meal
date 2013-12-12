class MyMailer
  include Sidekiq::Worker

  # def perform(name, count)
    
  # end

  def perform(address, owner, transaction, link)
    TransactionNotifier.user_email(address.email, transaction, link).deliver
    TransactionNotifier.user_email(owner.email, transaction, link).deliver
  end

end