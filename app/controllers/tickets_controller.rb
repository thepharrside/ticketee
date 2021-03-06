class TicketsController < ApplicationController
before_action :set_project
before_action :set_ticket, only: [:show, :edit, :update, :destroy]

def destroy
	authorize @ticket, :destroy?
	
	@ticket.destroy
	flash[:notice] = "Ticket has been deleted."

	redirect_to @project
end

def edit
  authorize @ticket, :update?
end

def new
	@ticket = @project.tickets.build
	authorize @ticket, :create?
end

def show
	authorize @ticket, :show?
end

def create
	@ticket = @project.tickets.build(ticket_params)
	@ticket.author = current_user
	authorize @ticket, :create?
	
	if @ticket.save
		flash[:notice] = "Ticket has been created."
		redirect_to [@project, @ticket]
	else
		flash.now[:alert] = "Ticket has not been created."
		render "new"
	end
end


def update
	authorize @ticket, :update?
	
	if @ticket.update(ticket_params)
		flash[:notice] = "Ticket has been updated."
		redirect_to [@project, @ticket]
	else
		flash.now[:alert] = "Ticket has not been updated."
		render "edit"
	end
end

private

def ticket_params
	params.require(:ticket).permit(:name, :description, :attachment, :attachment_cache)
end

def set_project
	@project = Project.find(params[:project_id])
end

def set_ticket
	@ticket = @project.tickets.find(params[:id])
end

end
