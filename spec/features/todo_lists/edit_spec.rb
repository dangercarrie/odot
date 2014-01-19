require 'spec_helper'

describe "Editing todo lists" do
	let!(:todo_list) { todo_list = TodoList.create(title: "Groceries", description: "Grocery List") }

	def update_todo_list(options={})
		options[:title] ||= "My Todo List"
		options[:description] ||= "This is what I'm doing today."
		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			 click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
		
	end

	it "should update a todo list succesfully" do
		
		update_todo_list todo_list: todo_list,
		title: "New Title",
		description: "New Description"

		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated.")
		expect(todo_list.title).to eq("New Title")
		expect(todo_list.description).to eq("New Description")
	end
	
end