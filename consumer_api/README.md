# Consumer API

### Pagination
The backend API supports pagination to efficiently handle large datasets. By default, the API returns the first 10 items per page. You can control the page number and the number of items per page through query parameters.

#### Default Pagination
If no pagination parameters are provided, the API will return the following default values:
* Page: 1
* Items per page: 10

#### Query Parameters
To customize the pagination, you can pass the following query parameters:
* page: The page number (defaults to 1 if not provided).
* per_page: The number of items per page (defaults to 10 if not provided).

#### Example Requests
* Default Pagination:
```bash
GET /api/v1/products
```
This will return the first page with 10 products.

* Custom Pagination::
```bash
GET /api/v1/products?page=2&per_page=5
```
This will return page 2 with 5 products per page.

#### Example Response
The API response includes the data array with the products and a meta object containing pagination information:
```bash
data: [
	{
		id: 2,
		product_id: "110816",
		brand: "BOSAL",
		product_name: "COMFORT PRO II",
		product_category_id: "572",
		country: "belgium",
		shop_name: "QUALITY-SHOPS AMAZON.PT",
		price: 513,
		url: "https://www.amazon.com.be/BOSAL-Trekhaak-fietsendrager-500-002-trekhaak/dp/B09QRB86JN?language=fr_BE&tag=testachats22-21",
		created_at: "2024-11-20T12:39:20.656Z",
		updated_at: "2024-11-20T18:43:19.410Z"
	}
],
meta: {
	current_page: 1,
	total_pages: 5212,
	total_count: 52119
}
```

