class FactsController < ApplicationController
  # Index action for showing all facts
  def index
    @facts = Fact.all
  end

  # Show action for showing a specific fact
  def show
    @fact = Fact.find(params[:id])
  end

  # New action for creating fact
  def new
    @fact = Fact.new
  end

  # Create action saves the fact into database
  def create
    @fact = Fact.new(fact_params)
    if @fact.save
      flash[:notice] = "Successfully created fact!"
      redirect_to fact_path(@fact)
    else
      flash[:alert] = "Error creating new fact!"
      render :new, status: :unprocessable_entity
    end
  end

  # Edit action for editing fact
  def edit
  end

  # Update action updates the fact with the new information
  def update 
  end

  # Destroy action deletes the fact
  def destroy
  end

  private
  def fact_params
    params.require(:fact).permit(:title, :body)
  end
end