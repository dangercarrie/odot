require 'spec_helper'

describe "Destroy todo list" do
	let!(:todo_list) { todo_list = TodoList.create(title: "Groceries", description: "Grocery List") }
	
	def destroy_todo_list(options={})
		options[:title] ||= "My Todo List"
		options[:description] ||= "This is what I'm doing today."
		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			 click_link "Destroy"
			end
	end

	it "should delete todo list" do
		destroy_todo_list todo_list: todo_list

		expect(page).to_not have_content(todo_list.title)	
		expect(TodoList.count).to eq(0)
	end	
end