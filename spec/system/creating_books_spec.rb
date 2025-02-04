require 'rails_helper'

RSpec.describe "CreatingBooks", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'saves a book with a title' do
    visit 'books/new'

    fill_in 'Title', with: 'Great Book'
    click_on 'Create Book'

    expect(page).to have_content("Book was successfully created.")


end

  it 'saves a book with empty title' do
    visit 'books/new'

    fill_in 'Title', with: ''
    click_on 'Create Book'

    expect(page).to have_content("Book was successfully created.")


end

it 'saves a book with an author' do
  visit 'books/new'

  fill_in 'Author', with: 'Earnest Hemingway'
  click_on 'Create Book'

  expect(page).to have_content('Book was successfully created.')
  book = Book.order('id').last
  expect(book.author).to eq('Earnest Hemingway')
end

it 'saves a book with a price' do
  visit 'books/new'

  fill_in 'Price', with: 4.25
  click_on 'Create Book'

  expect(page).to have_content('Book was successfully created.')
  book = Book.order('id').last
  expect(book.price).to eq(4.25)
end

it 'saves a book with a published date' do
  visit 'books/new'

  select '2025' , from: 'book_date_published_1i'
  select 'January', from: 'book_date_published_2i'
  select '1', from: 'book_date_published_3i'

  click_on 'Create Book'

  expect(page).to have_content('Book was successfully created.')
  book = Book.order('id').last
  expect(book.date_published).to eq(Date.new(2025,1,1))
end

it 'Author Integration' do
  visit 'books/new'

  fill_in 'Author', with: 'Earnest Hemingway'
  click_on 'Create Book'

  expect(page).to have_content('Book was successfully created.')
  visit ('books/' + String(Book.order('id').last.id))
  expect(page).to have_content('Earnest Hemingway')
end

it 'Price Integration' do
  visit 'books/new'

  fill_in 'Price', with: 4.25
  click_on 'Create Book'

  expect(page).to have_content('Book was successfully created.')
  visit ('books/' + String(Book.order('id').last.id))
  expect(page).to have_content('4.25')
end

it 'Published Date Integration' do
  visit 'books/new'

  select '2025' , from: 'book_date_published_1i'
  select 'January', from: 'book_date_published_2i'
  select '1', from: 'book_date_published_3i'

  click_on 'Create Book'

  expect(page).to have_content('Book was successfully created.')
  visit ('books/' + String(Book.order('id').last.id))
  expect(page).to have_content('2025-01-01')
end

end
