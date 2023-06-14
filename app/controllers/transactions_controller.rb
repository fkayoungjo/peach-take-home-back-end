class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update]
  protect_from_forgery except: :update

  # ...
  def index
    render json: Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
    render json: @transaction
  end 
  
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.json { render json: @transaction, status: :ok }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:category_id, :reviewed)
  end

 
end