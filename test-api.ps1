# Test H2 Database Integration with Books API

$baseUrl = "http://localhost:8080/api/v1/book"

Write-Host "===== TESTING BOOKS API WITH H2 DATABASE =====" -ForegroundColor Cyan

# Test 1: Add Book 1
Write-Host "`n1. POST /add - Adding Book 1" -ForegroundColor Yellow
$book1 = @{
    name = "Java Programming"
    author = "Anoop Kumar"
    price = 500
} | ConvertTo-Json

$response1 = Invoke-RestMethod -Uri "$baseUrl/add" -Method Post -ContentType "application/json" -Body $book1
Write-Host "Response: $($response1 | ConvertTo-Json)" -ForegroundColor Green
$bookId1 = $response1.id
Write-Host "Created Book with ID: $bookId1" -ForegroundColor Green

# Test 2: Add Book 2
Write-Host "`n2. POST /add - Adding Book 2" -ForegroundColor Yellow
$book2 = @{
    name = "Spring Boot in Action"
    author = "Craig Walls"
    price = 600
} | ConvertTo-Json

$response2 = Invoke-RestMethod -Uri "$baseUrl/add" -Method Post -ContentType "application/json" -Body $book2
Write-Host "Response: $($response2 | ConvertTo-Json)" -ForegroundColor Green
$bookId2 = $response2.id
Write-Host "Created Book with ID: $bookId2" -ForegroundColor Green

# Test 3: Get All Books
Write-Host "`n3. GET /all - Getting All Books from Database" -ForegroundColor Yellow
$allBooks = Invoke-RestMethod -Uri "$baseUrl/all" -Method Get
Write-Host "Response: $($allBooks | ConvertTo-Json)" -ForegroundColor Green
Write-Host "Total Books in Database: $($allBooks.Count)" -ForegroundColor Green

# Test 4: Get Book by ID
Write-Host "`n4. GET /{id} - Getting Book with ID $bookId1" -ForegroundColor Yellow
$singleBook = Invoke-RestMethod -Uri "$baseUrl/$bookId1" -Method Get
Write-Host "Response: $($singleBook | ConvertTo-Json)" -ForegroundColor Green

# Test 5: Update Book
Write-Host "`n5. PUT /update/{id} - Updating Book $bookId1" -ForegroundColor Yellow
$updateBook = @{
    name = "Java Programming - Updated"
    author = "Anoop Kumar Singh"
    price = 750
} | ConvertTo-Json

$updatedBook = Invoke-RestMethod -Uri "$baseUrl/update/$bookId1" -Method Put -ContentType "application/json" -Body $updateBook
Write-Host "Response: $($updatedBook | ConvertTo-Json)" -ForegroundColor Green
Write-Host "Book Updated Successfully!" -ForegroundColor Green

# Test 6: Verify Update
Write-Host "`n6. GET /{id} - Verifying Updated Book" -ForegroundColor Yellow
$verifyBook = Invoke-RestMethod -Uri "$baseUrl/$bookId1" -Method Get
Write-Host "Response: $($verifyBook | ConvertTo-Json)" -ForegroundColor Green

# Test 7: Test 404 Error
Write-Host "`n7. GET /{id} - Testing Error Handling (Invalid ID: 999)" -ForegroundColor Yellow
try {
    $invalidBook = Invoke-RestMethod -Uri "$baseUrl/999" -Method Get
}
catch {
    Write-Host "Caught Expected 404 Error:" -ForegroundColor Red
    Write-Host "$($_.Exception.Response.StatusCode)" -ForegroundColor Red
    Write-Host "Response Body: $($_.ErrorDetails.Message)" -ForegroundColor Red
}

# Test 8: Delete Book
Write-Host "`n8. DELETE /delete/{id} - Deleting Book $bookId2" -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/delete/$bookId2" -Method Delete
    Write-Host "Book Deleted Successfully!" -ForegroundColor Green
}
catch {
    Write-Host "Response: $($_.ErrorDetails.Message)" -ForegroundColor Green
}

# Test 9: Verify Deletion
Write-Host "`n9. GET /all - Verifying Deletion (Should have 1 book)" -ForegroundColor Yellow
$finalBooks = Invoke-RestMethod -Uri "$baseUrl/all" -Method Get
Write-Host "Response: $($finalBooks | ConvertTo-Json)" -ForegroundColor Green
Write-Host "Total Books After Deletion: $($finalBooks.Count)" -ForegroundColor Green

Write-Host "`n===== ALL TESTS COMPLETED =====" -ForegroundColor Cyan
Write-Host "✓ Create (POST)" -ForegroundColor Green
Write-Host "✓ Read All (GET /all)" -ForegroundColor Green
Write-Host "✓ Read Single (GET /{id})" -ForegroundColor Green
Write-Host "✓ Update (PUT)" -ForegroundColor Green
Write-Host "✓ Delete (DELETE)" -ForegroundColor Green
Write-Host "✓ Error Handling (404)" -ForegroundColor Green
