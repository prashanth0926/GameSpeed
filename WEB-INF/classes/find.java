import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;
import com.mongodb.ServerAddress;
import com.mongodb.AggregationOutput;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class find extends HttpServlet {

	private static final long serialVersionUID = 1L;
	MongoClient mongo;

	public void init() throws ServletException {
		// Connect to Mongo DB
		mongo = new MongoClient("localhost", 27017);

	}
	
	boolean filterByMaxprice = false;
	boolean filterByTop5 = false;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");

		PrintWriter output = response.getWriter();

		DB db = mongo.getDB("CustomerReviews");

		// If the collection does not exists, MongoDB will create it for you
		DBCollection myReviews = db.getCollection("myReviews");

		BasicDBObject query = new BasicDBObject();

		try {
			
			// Get the form data
			String productName = request.getParameter("productName");
			int productPrice = Integer.parseInt(request
					.getParameter("productPrice"));
			int retailerZip = Integer.parseInt(request
					.getParameter("retailerZip"));
			String retailerCity = request.getParameter("retailerCity");
			String productCategory = request.getParameter("productCategory");
			String retailerName = request.getParameter("retailerName");
			String retailerState = request.getParameter("retailerState");
			String sale = request.getParameter("sale");
			String manufacturerName = request.getParameter("manufacturerName");
			String rebate = request.getParameter("rebate");
			String emailID = request.getParameter("emailID");
			int userAge = Integer.parseInt(request.getParameter("userAge"));
			String userGender = request.getParameter("userGender");
			String userOccupation = request.getParameter("userOccupation");
			int reviewRating = Integer.parseInt(request
					.getParameter("reviewRating"));

			String reviewDate = request.getParameter("reviewDate");
			
			String reviewText = request.getParameter("reviewText");

			String compareRating = request.getParameter("compareRating");
			String comparePrice = request.getParameter("comparePrice");
			String compareAge = request.getParameter("compareRating");
			String compareDate = request.getParameter("comparePrice");
			String compareRating1 = request.getParameter("compareRating");

			String returnValueDropdown = request.getParameter("returnValue");
			String groupByDropdown = request.getParameter("groupByDropdown");
			int reviewRating1 = Integer.parseInt(request
					.getParameter("reviewRating1"));
			
			String groupByDropdown1 = request.getParameter("groupByDropdown1");
			
			// Boolean flags to check the filter settings
			boolean noFilter = false;
			boolean filterByProduct = false;
			boolean filterByPrice = false;
			boolean filterByZip = false;
			boolean filterByCity = false;
			boolean filterByRating = false;
			boolean filterByCategory = false;
			boolean filterByRetailer = false;
			boolean filterByState = false;
			boolean filterBySale = false;
			boolean filterByManufacturer = false;
			boolean filterByRebate = false;
			boolean filterByEmailid = false;
			boolean filterByAge = false;
			boolean filterByGender = false;
			boolean filterByOccupation = false;
			boolean filterByDate = false;
			boolean filterByText = false;

			boolean groupBy = false;
			boolean groupByCity = false;
			boolean groupByProduct = false;
			boolean groupByCategory = false;
			boolean groupByPrice = false;
			boolean groupByRetailer = false;
			boolean groupByState = false;
			boolean groupByZip = false;
			boolean groupBySale = false;
			boolean groupByManufacturer = false;
			boolean groupByRebate = false;
			boolean groupByEmailid = false;
			boolean groupByAge = false;
			boolean groupByGender = false;
			boolean groupByOccupation = false;
			boolean groupByRating = false;
			boolean groupByDate = false;

			boolean countOnly = false;

			boolean filterByRating1 = false;
			
		boolean advanced = false;
		boolean medianPrice = false;
		boolean expensive5 = false;
		boolean disliked5 = false;
		boolean ratingZip = false;
		boolean ageCity = false;
		boolean top5City = false;
		boolean reviewText1 = false;
			
			
			
			
			if(request.getParameter("find") != null) {
				
			// Get the filters selected
			// Filter - Simple Search
			String[] filters = request.getParameterValues("queryCheckBox");
			// Filters - Group By
			String[] extraSettings = request
					.getParameterValues("extraSettings");
			
			DBCursor dbCursor = null;
			AggregationOutput aggregateData = null;

			// Check for extra settings(Grouping Settings)
			if (extraSettings != null) {
				// User has selected extra settings
				groupBy = true;

				for (int x = 0; x < extraSettings.length; x++) {
					switch (extraSettings[x]) {
					case "COUNT_ONLY":
						countOnly = true;
						break;
					case "GROUP_BY":
						// Can add more grouping conditions here
						switch (groupByDropdown) {
						case "GROUP_BY_CITY":
							groupByCity = true;
							break;
						case "GROUP_BY_PRODUCT":
							groupByProduct = true;
							break;
						case "GROUP_BY_CATEGORY":
							groupByCategory = true;
							break;
						case "GROUP_BY_PRICE":
							groupByPrice = true;
							break;
						case "GROUP_BY_RETAILER":
							groupByRetailer = true;
							break;
						case "GROUP_BY_STATE":
							groupByState = true;
							break;
						case "GROUP_BY_ZIP":
							groupByZip = true;
							break;
						case "GROUP_BY_SALE":
							groupBySale = true;
							break;
						case "GROUP_BY_MANUFACTURER":
							groupByManufacturer = true;
							break;
						case "GROUP_BY_REBATE":
							groupByRebate = true;
							break;
						case "GROUP_BY_EMAILID":
							groupByEmailid = true;
							break;
						case "GROUP_BY_AGE":
							groupByAge = true;
							break;
						case "GROUP_BY_GENDER":
							groupByGender = true;
							break;
						case "GROUP_BY_OCCUPATION":
							groupByOccupation = true;
							break;
						case "GROUP_BY_RATING":
							groupByRating = true;
							break;
						case "GROUP_BY_DATE":
							groupByDate = true;
							break;
						default:
							groupBy = true;
							break;
						}
						break;

					case "REVIEW_RATING":
						filterByRating1 = true;
						break;
					
					case "MAX_PRICE":
						filterByMaxprice = true;
						break;
						
					case "TOP5_LIKED":
						filterByTop5 = true;
						break;
									
					default:
						break;
					}
				}
			}

			// Check the main filters only if the 'groupBy' option is not
			// selected
			if (filters != null && !groupBy) {
				for (int i = 0; i < filters.length; i++) {
					// Check what all filters are ON
					// Build the query accordingly
					switch (filters[i]) {
					case "productName":
						filterByProduct = true;
						if (!productName.equals("ALL_PRODUCTS")) {
							query.put("productName", productName);
						}
						break;

					case "productCategory":
						filterByCategory = true;
						query.put("productCategory", productCategory);
						break;

					case "productPrice":
						filterByPrice = true;
						if (comparePrice.equals("EQUALS_TO")) {
							query.put("productPrice", productPrice);
						} else if (comparePrice.equals("GREATER_THAN")) {
							query.put("productPrice", new BasicDBObject("$gt",
									productPrice));
						} else if (comparePrice.equals("LESS_THAN")) {
							query.put("productPrice", new BasicDBObject("$lt",
									productPrice));
						}
						break;

					case "retailerName":
						filterByRetailer = true;
						query.put("retailerName", retailerName);
						break;

					case "retailerZip":
						filterByZip = true;
						query.put("retailerZip", retailerZip);
						break;

					case "retailerCity":
						filterByCity = true;
						if (!retailerCity.equals("ALL")) {
							query.put("retailerCity", retailerCity);
						}
						break;

					case "retailerState":
						filterByState = true;
						if (!retailerState.equals("ALL")) {
							query.put("retailerState", retailerState);
						}
						break;

					case "sale":
						filterBySale = true;
						query.put("sale", sale);
						break;

					case "manufacturerName":
						filterByManufacturer = true;
						query.put("manufacturerName", manufacturerName);
						break;

					case "rebate":
						filterByRebate = true;
						query.put("rebate", rebate);
						break;

					case "emailID":
						filterByEmailid = true;
						if (!emailID.equals("ALL")) {
							query.put("emailID", emailID);
						}
						break;

					case "userAge":
						filterByAge = true;
						if (compareAge.equals("EQUALS_TO")) {
							query.put("userAge", userAge);
						} else if (compareAge.equals("GREATER_THAN")) {
							query.put("userAge", new BasicDBObject("$gt",
									userAge));
						} else if (compareAge.equals("LESS_THAN")) {
							query.put("userAge", new BasicDBObject("$lt",
									userAge));
						}
						break;

					case "userGender":
						filterByGender = true;
						query.put("userGender", userGender);
						break;

					case "userOccupation":
						filterByOccupation = true;
						if (!userOccupation.equals("ALL")) {
							query.put("userOccupation", userOccupation);
						}
						break;

					case "reviewRating":
						filterByRating = true;
						if (compareRating.equals("EQUALS_TO")) {
							query.put("reviewRating", reviewRating);
						} else if (compareRating.equals("GREATER_THAN")) {
							query.put("reviewRating", new BasicDBObject("$gt",
									reviewRating));
						} else if (compareRating.equals("LESS_THAN")) {
							query.put("reviewRating", new BasicDBObject("$lt",
									reviewRating));
						}
						break;

					case "reviewDate":
						filterByDate = true;
						if (compareRating.equals("EQUALS_TO")) {
							query.put("reviewDate", reviewDate);
						} else if (compareRating.equals("GREATER_THAN")) {
							query.put("reviewDate", new BasicDBObject("$gt",
									reviewDate));
						} else if (compareRating.equals("LESS_THAN")) {
							query.put("reviewDate", new BasicDBObject("$lt",
									reviewDate));
						}
						break;

					case "reviewText":
						filterByText = true;
						String pattern = ".*"+reviewText+".*";
						//BasicDBObject match1 = new BasicDBObject("$match",new BasicDBObject("reviewText", new BasicDBObject("$regex", pattern)));
						if (!reviewText.equals("ALL")) {
							query.put("reviewText", new BasicDBObject("$regex", pattern));
						}

					default:
						// Show all the reviews if nothing is selected
						noFilter = true;
						break;
					}
				}
			} else {
				// Show all the reviews if nothing is selected
				noFilter = true;
			}

			// Construct the top of the page
			constructPageTop(output);

			// Run the query
			if (groupBy) {
				// Run the query using aggregate function
				DBObject matchFields = null;
				DBObject match = null;
				DBObject sortField = null;
				DBObject sort = null;
				DBObject limit = null;
				DBObject groupFields = null;
				DBObject group = null;
				DBObject projectFields = null;
				DBObject project = null;
				AggregationOutput aggregate = null;
				
				if (groupByCity) {

					if (filterByRating1) {
						matchFields = new BasicDBObject();
						if (compareRating1.equals("EQUALS_TO")) {
							matchFields.put("reviewRating", reviewRating1);
						} else if (compareRating1.equals("GREATER_THAN")) {
							matchFields.put("reviewRating", new BasicDBObject(
									"$gt", reviewRating1));
						} else if (compareRating1.equals("LESS_THAN")) {
							matchFields.put("reviewRating", new BasicDBObject(
									"$lt", reviewRating1));
						}
						match = new BasicDBObject("$match", matchFields);
					}
										
					groupFields = new BasicDBObject("_id", 0);
					/*if (filterByTop5 || Trending) {
					groupFields.put("_id", new BasicDBObject("city", "$retailerCity").append("ratng", "$reviewRating"));
					}*/
					groupFields.put("_id", "$retailerCity");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("maxprice", new BasicDBObject("$max", "$productPrice"));
					groupFields.put("productPrice", new BasicDBObject("$push",
							"$productPrice"));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));
					group = new BasicDBObject("$group", groupFields);
					
					if (filterByTop5) {
						//sortField = new BasicDBObject("count", 1);
						sortField = new BasicDBObject("reviewRating", 1);
						sort = new BasicDBObject("$sort", sortField);
					}
					
					/*if(Trending){
						sortField = new BasicDBObject("rating", -1);
						sort = new BasicDBObject("$sort", sortField);
					}*/
					
					/*if(filterByMaxprice){
						sortField = new BasicDBObject("productPrice", 1);
						sort = new BasicDBObject("$sort", sortField);
					}*/
					
					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("City", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Price", "$productPrice");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");
					projectFields.put("MaxPrice", "$maxprice");
					
					project = new BasicDBObject("$project", projectFields);
					
					if (filterByRating1) {
						aggregate = myReviews.aggregate(match, group, project);
					}else if (filterByTop5) {
						aggregate = myReviews.aggregate(sort, group, project);
					}else {
					aggregate = myReviews.aggregate(group, project);
					}
					// Construct the page content
					constructGroupByCityContent(aggregate, output, countOnly);

				} else if (groupByProduct) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$productName");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Product", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByProductContent(aggregate, output, countOnly);

				} else if (groupByCategory) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$productCategory");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Category", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByCategoryContent(aggregate, output, countOnly);
				} else if (groupByPrice) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$productPrice");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Price", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByPriceContent(aggregate, output, countOnly);
				} else if (groupByRetailer) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$retailerName");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Retailer", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByRetailerContent(aggregate, output, countOnly);
				} else if (groupByState) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$retailerState");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("State", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByStateContent(aggregate, output, countOnly);
				} else if (groupByZip) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$retailerZip");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productPrice", new BasicDBObject("$push",
							"$productPrice"));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("maxprice", new BasicDBObject("$max", "$productPrice"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Zip", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");
					projectFields.put("Price", "$productPrice");
					projectFields.put("MaxPrice", "$maxprice");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByZipContent(aggregate, output, countOnly);
				} else if (groupBySale) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$sale");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Sale", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupBySaleContent(aggregate, output, countOnly);
				} else if (groupByManufacturer) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$manufacturerName");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Manufacturer", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByManufacturerContent(aggregate, output, countOnly);
				} else if (groupByRebate) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$rebate");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Rebate", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByRebateContent(aggregate, output, countOnly);
				} else if (groupByEmailid) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$emailID");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Emailid", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByEmailidContent(aggregate, output, countOnly);
				} else if (groupByAge) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$userAge");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Age", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByAgeContent(aggregate, output, countOnly);
				} else if (groupByGender) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$userGender");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Gender", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByGenderContent(aggregate, output, countOnly);
				} else if (groupByOccupation) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$userOccupation");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Occupation", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByOccupationContent(aggregate, output, countOnly);
				} else if (groupByRating) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$reviewRating");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("rating", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByRatingContent(aggregate, output, countOnly);
				} else if (groupByDate) {

					groupFields = new BasicDBObject("_id", 0);
					groupFields.put("_id", "$reviewDate");
					groupFields.put("count", new BasicDBObject("$sum", 1));
					groupFields.put("productName", new BasicDBObject("$push",
							"$productName"));
					groupFields.put("review", new BasicDBObject("$push",
							"$reviewText"));
					groupFields.put("rating", new BasicDBObject("$push",
							"$reviewRating"));

					group = new BasicDBObject("$group", groupFields);

					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Date", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");

					project = new BasicDBObject("$project", projectFields);

					aggregate = myReviews.aggregate(group, project);

					// Construct the page content
					constructGroupByDateContent(aggregate, output, countOnly);
				}

			} 
			
			else {
				// Check the return value selected
				int returnLimit = 0;

				// Create sort variable
				DBObject sort = new BasicDBObject();

				if (returnValueDropdown.equals("TOP_5")) {
					// Top 5 - Sorted by review rating
					returnLimit = 5;
					sort.put("reviewRating", -1);
					dbCursor = myReviews.find(query).limit(returnLimit)
							.sort(sort);
				} else if (returnValueDropdown.equals("TOP_10")) {
					// Top 10 - Sorted by review rating
					returnLimit = 10;
					sort.put("reviewRating", -1);
					dbCursor = myReviews.find(query).limit(returnLimit)
							.sort(sort);
				} else if (returnValueDropdown.equals("LATEST_5")) {
					// Latest 5 - Sort by date
					returnLimit = 5;
					sort.put("reviewDate", -1);
					dbCursor = myReviews.find(query).limit(returnLimit)
							.sort(sort);
				} else if (returnValueDropdown.equals("LATEST_10")) {
					// Latest 10 - Sort by date
					returnLimit = 10;
					sort.put("reviewDate", -1);
					dbCursor = myReviews.find(query).limit(returnLimit)
							.sort(sort);
				} else {
					// Run the simple search query(default result)
					dbCursor = myReviews.find(query);
				}

				// Construct the page content
				constructDefaultContent(dbCursor, output, countOnly);
			}

			// Construct the bottom of the page
			constructPageBottom(output);
			
			}
			else if(request.getParameter("trending") != null) {
				DBObject matchFields = null;
				DBObject match = null;
				DBObject sortField = null;
				DBObject sort = null;
				DBObject sortField1 = null;
				DBObject sort1 = null;
				DBObject limit = null;
				DBObject groupFields = null;
				DBObject group = null;
				DBObject groupFields1 = null;
				DBObject group1 = null;
				DBObject projectFields = null;
				DBObject project = null;
				AggregationOutput aggregate = null;
				
				constructPageTop(output);
				
						matchFields = new BasicDBObject();
						matchFields.put("reviewRating", 5);
						match = new BasicDBObject("$match", matchFields);
				
				sortField = new BasicDBObject();
				sortField.put("retailerCity", 1);
				sort = new BasicDBObject("$sort", sortField);
					
				groupFields1 = new BasicDBObject("_id", 0);
				groupFields1.put("_id", "$retailerCity");
				groupFields1.put("count", new BasicDBObject("$sum", 1));
				groupFields1.put("maxprice", new BasicDBObject("$max", "$productPrice"));
				groupFields1.put("productPrice", new BasicDBObject("$push",
						"$productPrice"));
				groupFields1.put("productName", new BasicDBObject("$push",
						"$productName"));
				groupFields1.put("review", new BasicDBObject("$push",
						"$reviewText"));
				groupFields1.put("rating", new BasicDBObject("$push",
						"$reviewRating"));
				
				group1 = new BasicDBObject("$group", groupFields1);
				
				sortField1 = new BasicDBObject();
				sortField1.put("city", 1);
				sortField1.put("count", -1);
				sort1 = new BasicDBObject("$sort", sortField1);		
																								
					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("City", "$_id");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Price", "$productPrice");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");
					projectFields.put("MaxPrice", "$maxprice");
					
					project = new BasicDBObject("$project", projectFields);			
					
						aggregate = myReviews.aggregate(sort, match, group1, sort1, project);
					
					// Construct the page content
					//constructGroupByCityContent(aggregate, output, countOnly);

						int rowCount = 0;
						int productCount = 0;
						String tableData = " ";
						String pageContent = " ";
						String RevCnt = " ";
						String city1 = " ";
						String city2 = " ";
						
						output.println("<h1> Grouped By - City </h1>");
						for (DBObject result : aggregate.results()) {
							BasicDBObject bobj = (BasicDBObject) result;
							BasicDBList productList = (BasicDBList) bobj.get("Product");
							BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
							BasicDBList rating = (BasicDBList) bobj.get("Rating");
							BasicDBList price = (BasicDBList) bobj.get("Price");
							
							rowCount++;
														
							RevCnt = "1";
							city1 = bobj.getString("City").toString();
							
							if (!city1.equals(city2)) {
								
							
							tableData = "<tr><td>City: " + bobj.getString("City")
									+ "</td>&nbsp" + "<td>Reviews Found: "
									+ RevCnt + "</td></tr>";
							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
							
							tableData = "<tr rowspan = \"4\"><td> Product: "
											+ productList.get(productCount) + "</br>"
											+ "Rating: " + rating.get(productCount) + "</br>"
											+ "Price: : " + price.get(productCount)
											+ "</td></tr>";

									pageContent = "<table class = \"query-table\">" + tableData
											+ "</table>";
									output.println(pageContent);
									
								}
							
							city2 = city1;
							
								
						}						
						// No data found
						if (rowCount == 0) {
							pageContent = "<h5>No Data Found</h5>";
							output.println(pageContent);
						}


					
					
				//construct page bottom	
				constructPageBottom(output);
			}
			else if(request.getParameter("advancedsearch") != null) {
				
				constructPageTop(output);
				
				String[] extraSettings1 = request
						.getParameterValues("extraSettings1");
				
				AggregationOutput aggregateData = null;

				// Check for extra settings(Grouping Settings)
				if (extraSettings1 != null) {
					// User has selected extra settings
					advanced = true;

					for (int x = 0; x < extraSettings1.length; x++) {
						switch (extraSettings1[x]) {
						case "TEXT":
							reviewText1 = true;
							break;
						case "ADVANCED":
							switch(groupByDropdown1){
							case "MEDIAN":	medianPrice = true;
								break;
							case "TOP5_EXPENSIVE":	expensive5 = true;
								break;
							case "TOP5_DISLIKED":	disliked5 = true;
								break;
							case "RATING5_ZIP":	ratingZip = true;
								break;
							case "AGE_CITY":	ageCity = true;
								break;
							case "TOP5_LIKE":	top5City = true;
								break;
							}
							break;
						}
					}
				}
								
				if (advanced) {
					
					DBObject matchFields = null;
					DBObject match = null;
					DBObject sortField = null;
					DBObject sort = null;
					DBObject sortField1 = null;
					DBObject sort1 = null;
					DBObject limit = null;
					DBObject groupFields = null;
					DBObject group = null;
					DBObject groupFields1 = null;
					DBObject group1 = null;
					DBObject projectFields = null;
					DBObject project = null;
					AggregationOutput aggregate = null;
					
					int rowCount = 0;
					int productCount = 0;
					String tableData = " ";
					String pageContent = " ";
					String RevCnt = " ";
					String city1 = " ";
					String city2 = " ";
									
					if(medianPrice){			
						sortField = new BasicDBObject();
						sortField.put("productPrice", 1);
						sort = new BasicDBObject("$sort", sortField);
							
						groupFields1 = new BasicDBObject("_id", 0);
						groupFields1.put("_id", "$retailerCity");
						groupFields1.put("count", new BasicDBObject("$sum", 1));
						groupFields1.put("maxprice", new BasicDBObject("$max", "$productPrice"));
						groupFields1.put("productPrice", new BasicDBObject("$push",
								"$productPrice"));
						groupFields1.put("productName", new BasicDBObject("$push",
								"$productName"));
						groupFields1.put("review", new BasicDBObject("$push",
								"$reviewText"));
						groupFields1.put("rating", new BasicDBObject("$push",
								"$reviewRating"));
						
						group1 = new BasicDBObject("$group", groupFields1);
																																
							projectFields = new BasicDBObject("_id", 0);
							projectFields.put("City", "$_id");
							projectFields.put("Review Count", "$count");
							projectFields.put("Product", "$productName");
							projectFields.put("Price", "$productPrice");
							projectFields.put("Reviews", "$review");
							projectFields.put("Rating", "$rating");
							projectFields.put("MaxPrice", "$maxprice");
							
							project = new BasicDBObject("$project", projectFields);			
							
								aggregate = myReviews.aggregate(sort, group1, project);
							
							// Construct the page content
							//constructGroupByCityContent(aggregate, output, countOnly);
								
								output.println("<h1> Grouped By - City </h1>");
								for (DBObject result : aggregate.results()) {
									BasicDBObject bobj = (BasicDBObject) result;
									BasicDBList productList = (BasicDBList) bobj.get("Product");
									BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
									BasicDBList rating = (BasicDBList) bobj.get("Rating");
									BasicDBList price = (BasicDBList) bobj.get("Price");
									
									rowCount++;
									
									RevCnt = "1";							
									int rcnt = productList.size();
									int rem = 0;
									int rnt = 1;
									String a1 = " ";
									
									a1 = " "+price.get(rcnt/2)+" ";
									/*rem = rcnt % 2;
									System.out.println("*********************");
									System.out.println("rem="+rem);
									System.out.println("*********************");
									
									
									if(rem != 2%2) {
										rnt = (rcnt+1)/2;
										a1 = " "+price.get(rnt)+" ";
									}else {
										rnt = (rcnt)/2;
										a1 = " "+price.get(rnt)+" ";
									}*/
									
									tableData = "<tr><td>City: " + bobj.getString("City")
											+ "</td>&nbsp" + "<td>Reviews Found: "
											+ RevCnt + "</td></tr>";
									pageContent = "<table class = \"query-table\">" + tableData
											+ "</table>";
									output.println(pageContent);
									
									tableData = "<tr rowspan = \"4\"><td>"
													+ "Median Product Price: " + a1
													+ "</td></tr>";

											pageContent = "<table class = \"query-table\">" + tableData
													+ "</table>";
											output.println(pageContent);			
								}						
								// No data found
								if (rowCount == 0) {
									pageContent = "<h5>No Data Found</h5>";
									output.println(pageContent);
								}
							
					}else if(expensive5) {
						
						
						sortField = new BasicDBObject();
						sortField.put("reviewRating", 1);
						sortField.put("productPrice", 1);
						sort = new BasicDBObject("$sort", sortField);
							
						groupFields1 = new BasicDBObject("_id", 0);
						groupFields1.put("_id", "$retailerCity");
						groupFields1.put("count", new BasicDBObject("$sum", 1));
						groupFields1.put("maxprice", new BasicDBObject("$max", "$productPrice"));
						groupFields1.put("productPrice", new BasicDBObject("$push",
								"$productPrice"));
						groupFields1.put("productName", new BasicDBObject("$push",
								"$productName"));
						groupFields1.put("review", new BasicDBObject("$push",
								"$reviewText"));
						groupFields1.put("rating", new BasicDBObject("$push",
								"$reviewRating"));
						groupFields1.put("retailer", new BasicDBObject("$push",
								"$retailerName"));
						
						group1 = new BasicDBObject("$group", groupFields1);
						
						sortField1 = new BasicDBObject();
						sortField1.put("retailer", 1);
						sort1 = new BasicDBObject("$sort", sortField1);
						
																																						
							projectFields = new BasicDBObject("_id", 0);
							projectFields.put("City", "$_id");
							projectFields.put("Review Count", "$count");
							projectFields.put("Product", "$productName");
							projectFields.put("Price", "$productPrice");
							projectFields.put("Reviews", "$review");
							projectFields.put("Rating", "$rating");
							projectFields.put("MaxPrice", "$maxprice");
							projectFields.put("Retailer", "$retailer");
							
							project = new BasicDBObject("$project", projectFields);			
							
								aggregate = myReviews.aggregate(sort, group1, sort1, project);
												
						output.println("<h1> Grouped By - City </h1>");
						for (DBObject result : aggregate.results()) {
							BasicDBObject bobj = (BasicDBObject) result;
							BasicDBList productList = (BasicDBList) bobj.get("Product");
							BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
							BasicDBList rating = (BasicDBList) bobj.get("Rating");
							BasicDBList price = (BasicDBList) bobj.get("Price");
							BasicDBList retailer = (BasicDBList) bobj.get("Retailer");
							
							rowCount++;
																												
							if(productList.size()>5) {
									productCount = productList.size()-5;
									RevCnt = "5";
								} else {
									RevCnt = bobj.getString("Review Count");
									productCount = 0;
								}						
							
							tableData = "<tr><td>City: " + bobj.getString("City")
									+ "</td>&nbsp" + "<td>Reviews Found: "
									+ RevCnt + "</td></tr>";
							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
																						
							while (productCount < productList.size()) {	
									
										tableData = "<tr rowspan = \"4\"><td> Product: "
											+ productList.get(productCount) + "</br>"
											+ "Rating: " + rating.get(productCount) + "</br>"
											+ "Review: " + productReview.get(productCount) + "</br>"
											+ "Retailer Name: " + retailer.get(productCount) + "</br>"
													+ "Price: : " + price.get(productCount)
											+ "</td></tr>";

									pageContent = "<table class = \"query-table\">" + tableData
											+ "</table>";
									output.println(pageContent);
							
																							
									productCount++;
									
								}
															
								productCount = 0;
			
						}
						
						if (rowCount == 0) {
							pageContent = "<h5>No Data Found</h5>";
							output.println(pageContent);
						}
						
					} else if(disliked5) {
						
						
						sortField = new BasicDBObject();
						sortField.put("reviewRating", -1);
						sort = new BasicDBObject("$sort", sortField);
							
						groupFields1 = new BasicDBObject("_id", 0);
						groupFields1.put("_id", "$retailerCity");
						groupFields1.put("count", new BasicDBObject("$sum", 1));
						groupFields1.put("maxprice", new BasicDBObject("$max", "$productPrice"));
						groupFields1.put("productPrice", new BasicDBObject("$push",
								"$productPrice"));
						groupFields1.put("productName", new BasicDBObject("$push",
								"$productName"));
						groupFields1.put("review", new BasicDBObject("$push",
								"$reviewText"));
						groupFields1.put("rating", new BasicDBObject("$push",
								"$reviewRating"));
						groupFields1.put("retailer", new BasicDBObject("$push",
								"$retailerName"));
						
						group1 = new BasicDBObject("$group", groupFields1);
						
						sortField1 = new BasicDBObject();
						sortField1.put("retailer", 1);
						sort1 = new BasicDBObject("$sort", sortField1);
						
																																						
							projectFields = new BasicDBObject("_id", 0);
							projectFields.put("City", "$_id");
							projectFields.put("Review Count", "$count");
							projectFields.put("Product", "$productName");
							projectFields.put("Price", "$productPrice");
							projectFields.put("Reviews", "$review");
							projectFields.put("Rating", "$rating");
							projectFields.put("MaxPrice", "$maxprice");
							projectFields.put("Retailer", "$retailer");
							
							project = new BasicDBObject("$project", projectFields);			
							
								aggregate = myReviews.aggregate(sort, group1, sort1, project);
												
						output.println("<h1> Grouped By - City </h1>");
						for (DBObject result : aggregate.results()) {
							BasicDBObject bobj = (BasicDBObject) result;
							BasicDBList productList = (BasicDBList) bobj.get("Product");
							BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
							BasicDBList rating = (BasicDBList) bobj.get("Rating");
							BasicDBList price = (BasicDBList) bobj.get("Price");
							BasicDBList retailer = (BasicDBList) bobj.get("Retailer");
							
							rowCount++;
																												
							if(productList.size()>5) {
									productCount = productList.size()-5;
									RevCnt = "5";
								} else {
									RevCnt = bobj.getString("Review Count");
									productCount = 0;
								}						
							
							tableData = "<tr><td>City: " + bobj.getString("City")
									+ "</td>&nbsp" + "<td>Reviews Found: "
									+ RevCnt + "</td></tr>";
							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
																						
							while (productCount < productList.size()) {	
									
										tableData = "<tr rowspan = \"4\"><td> Product: "
											+ productList.get(productCount) + "</br>"
											+ "Rating: " + rating.get(productCount) + "</br>"
											+ "Review: " + productReview.get(productCount) + "</br>"
											+ "Retailer Name: " + retailer.get(productCount) + "</br>"
													+ "Price: : " + price.get(productCount)
											+ "</td></tr>";

									pageContent = "<table class = \"query-table\">" + tableData
											+ "</table>";
									output.println(pageContent);
							
																							
									productCount++;
									
								}
															
								productCount = 0;
			
						}
						
						if (rowCount == 0) {
							pageContent = "<h5>No Data Found</h5>";
							output.println(pageContent);
						}
						
					} else if (ratingZip) {
					
						matchFields = new BasicDBObject();
						matchFields.put("reviewRating", 5);
						match = new BasicDBObject("$match", matchFields);
									
				groupFields1 = new BasicDBObject("_id", 0);
				groupFields1.put("_id", new BasicDBObject("zip", "$retailerZip").append("name", "$productName").append("rtng", "$reviewRating"));
				groupFields1.put("count", new BasicDBObject("$sum", 1));
				groupFields1.put("maxprice", new BasicDBObject("$max", "$productPrice"));
				groupFields1.put("productPrice", new BasicDBObject("$push",
						"$productPrice"));
				groupFields1.put("productName", new BasicDBObject("$push",
						"$productName"));
				groupFields1.put("review", new BasicDBObject("$push",
						"$reviewText"));
				groupFields1.put("rating", new BasicDBObject("$push",
						"$reviewRating"));
				
				group1 = new BasicDBObject("$group", groupFields1);
				
				sortField1 = new BasicDBObject();
				sortField1.put("count", -1);
				sort1 = new BasicDBObject("$sort", sortField1);		
				
				limit = new BasicDBObject("$limit", 2);
																								
					projectFields = new BasicDBObject("_id", 0);
					projectFields.put("Zip", "$_id.zip");
					projectFields.put("Review Count", "$count");
					projectFields.put("Product", "$productName");
					projectFields.put("Price", "$productPrice");
					projectFields.put("Reviews", "$review");
					projectFields.put("Rating", "$rating");
					projectFields.put("MaxPrice", "$maxprice");
					
					project = new BasicDBObject("$project", projectFields);			
					
						aggregate = myReviews.aggregate(match, group1, sort1, limit, project);
					
					// Construct the page content
					//constructGroupByCityContent(aggregate, output, countOnly);
						
						output.println("<h1> Grouped By - Zip Code </h1>");
						for (DBObject result : aggregate.results()) {
							BasicDBObject bobj = (BasicDBObject) result;
							BasicDBList productList = (BasicDBList) bobj.get("Product");
							BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
							BasicDBList rating = (BasicDBList) bobj.get("Rating");
							BasicDBList price = (BasicDBList) bobj.get("Price");
							
							rowCount++;
														
							RevCnt = bobj.getString("Review Count");
														
							tableData = "<tr><td>Zip Code: " + bobj.getString("Zip")
									+ "</td>&nbsp" + "<td>Reviews Found: "
									+ RevCnt + "</td></tr>";
							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
							
							while(productCount < productList.size()){
							tableData = "<tr rowspan = \"4\"><td> Product: "
											+ productList.get(productCount) + "</br>"
											+ "Rating: " + rating.get(productCount) + "</br>"
											+ "Price: : " + price.get(productCount)
											+ "</td></tr>";

									pageContent = "<table class = \"query-table\">" + tableData
											+ "</table>";
									output.println(pageContent);
							productCount++;		
							}
							productCount=0;		
								
								
						}						
						// No data found
						if (rowCount == 0) {
							pageContent = "<h5>No Data Found</h5>";
							output.println(pageContent);
						}

						
						
					} else if(ageCity){
						
						matchFields = new BasicDBObject();
						matchFields.put("userAge", new BasicDBObject("$gt", 50));
						match = new BasicDBObject("$match", matchFields);
							
						groupFields1 = new BasicDBObject("_id", 0);
						groupFields1.put("_id", "$retailerCity");
						groupFields1.put("count", new BasicDBObject("$sum", 1));
						groupFields1.put("maxprice", new BasicDBObject("$max", "$productPrice"));
						groupFields1.put("productPrice", new BasicDBObject("$push",
								"$productPrice"));
						groupFields1.put("productName", new BasicDBObject("$push",
								"$productName"));
						groupFields1.put("review", new BasicDBObject("$push",
								"$reviewText"));
						groupFields1.put("rating", new BasicDBObject("$push",
								"$reviewRating"));
						groupFields1.put("retailer", new BasicDBObject("$push",
								"$retailerName"));
						groupFields1.put("age", new BasicDBObject("$push",
								"$userAge"));
						group1 = new BasicDBObject("$group", groupFields1);
						
						sortField1 = new BasicDBObject();
						sortField1.put("userAge", 1);
						sort1 = new BasicDBObject("$sort", sortField1);
						
																																						
							projectFields = new BasicDBObject("_id", 0);
							projectFields.put("City", "$_id");
							projectFields.put("Review Count", "$count");
							projectFields.put("Product", "$productName");
							projectFields.put("Price", "$productPrice");
							projectFields.put("Reviews", "$review");
							projectFields.put("Rating", "$rating");
							projectFields.put("MaxPrice", "$maxprice");
							projectFields.put("Age", "$age");
							
							project = new BasicDBObject("$project", projectFields);			
							
								aggregate = myReviews.aggregate(match, sort1, group1, project);
												
						output.println("<h1> Grouped By - City </h1>");
						for (DBObject result : aggregate.results()) {
							BasicDBObject bobj = (BasicDBObject) result;
							BasicDBList productList = (BasicDBList) bobj.get("Product");
							BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
							BasicDBList rating = (BasicDBList) bobj.get("Rating");
							BasicDBList price = (BasicDBList) bobj.get("Price");
							BasicDBList age = (BasicDBList) bobj.get("Age");
							
							rowCount++;
																												
							RevCnt = bobj.getString("Review Count");
							
							tableData = "<tr><td>City: " + bobj.getString("City")
									+ "</td>&nbsp" + "<td>Reviews Found: "
									+ RevCnt + "</td></tr>";
							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
																						
							while (productCount < productList.size()) {	
									
										tableData = "<tr rowspan = \"4\"><td> Product: "
											+ productList.get(productCount) + "</br>"
											+ "Rating: " + rating.get(productCount) + "</br>"
											+ "Review: " + productReview.get(productCount) + "</br>"
											+ "Age: " + age.get(productCount) + "</br>"
													+ "Price: : " + price.get(productCount)
											+ "</td></tr>";

									pageContent = "<table class = \"query-table\">" + tableData
											+ "</table>";
									output.println(pageContent);
							
																							
									productCount++;
									
								}
															
								productCount = 0;
			
						}
						
						if (rowCount == 0) {
							pageContent = "<h5>No Data Found</h5>";
							output.println(pageContent);
						}
						
					} else if(top5City) {
						
						sortField = new BasicDBObject();
						sortField.put("reviewRating", 1);
						sort = new BasicDBObject("$sort", sortField);
							
						groupFields1 = new BasicDBObject("_id", 0);
						groupFields1.put("_id", "$retailerCity");
						groupFields1.put("count", new BasicDBObject("$sum", 1));
						groupFields1.put("maxprice", new BasicDBObject("$max", "$productPrice"));
						groupFields1.put("productPrice", new BasicDBObject("$push",
								"$productPrice"));
						groupFields1.put("productName", new BasicDBObject("$push",
								"$productName"));
						groupFields1.put("review", new BasicDBObject("$push",
								"$reviewText"));
						groupFields1.put("rating", new BasicDBObject("$push",
								"$reviewRating"));
						groupFields1.put("manufacturer", new BasicDBObject("$push",
								"$manufacturerName"));
						
						group1 = new BasicDBObject("$group", groupFields1);
						
						sortField1 = new BasicDBObject();
						sortField1.put("manufacturerName", 1);
						sort1 = new BasicDBObject("$sort", sortField1);
						
																																						
							projectFields = new BasicDBObject("_id", 0);
							projectFields.put("City", "$_id");
							projectFields.put("Review Count", "$count");
							projectFields.put("Product", "$productName");
							projectFields.put("Price", "$productPrice");
							projectFields.put("Reviews", "$review");
							projectFields.put("Rating", "$rating");
							projectFields.put("MaxPrice", "$maxprice");
							projectFields.put("Manufacturer", "$manufacturer");
							
							project = new BasicDBObject("$project", projectFields);			
							
								aggregate = myReviews.aggregate(sort, group1, sort1, project);
												
						output.println("<h1> Grouped By - City </h1>");
						for (DBObject result : aggregate.results()) {
							BasicDBObject bobj = (BasicDBObject) result;
							BasicDBList productList = (BasicDBList) bobj.get("Product");
							BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
							BasicDBList rating = (BasicDBList) bobj.get("Rating");
							BasicDBList price = (BasicDBList) bobj.get("Price");
							BasicDBList manufacturer = (BasicDBList) bobj.get("Manufacturer");
							
							rowCount++;
																												
							if(productList.size()>5) {
									productCount = productList.size()-5;
									RevCnt = "5";
								} else {
									RevCnt = bobj.getString("Review Count");
									productCount = 0;
								}						
							
							tableData = "<tr><td>City: " + bobj.getString("City")
									+ "</td>&nbsp" + "<td>Reviews Found: "
									+ RevCnt + "</td></tr>";
							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
																						
							while (productCount < productList.size()) {	
									
										tableData = "<tr rowspan = \"4\"><td> Product: "
											+ productList.get(productCount) + "</br>"
											+ "Rating: " + rating.get(productCount) + "</br>"
											+ "Review: " + productReview.get(productCount) + "</br>"
											+ "Manufacturer Name: " + manufacturer.get(productCount) + "</br>"
													+ "Price: : " + price.get(productCount)
											+ "</td></tr>";

									pageContent = "<table class = \"query-table\">" + tableData
											+ "</table>";
									output.println(pageContent);
							
																							
									productCount++;
									
								}
															
								productCount = 0;
			
						}
						
						if (rowCount == 0) {
							pageContent = "<h5>No Data Found</h5>";
							output.println(pageContent);
						}
						
					} else if(reviewText1){
						
						
						
					}
					
					
					
					}
							
				constructPageBottom(output);
					
			}
				

		} catch (MongoException e) {
			e.printStackTrace();
		}catch(Exception ex){
	    		ex.printStackTrace();
	    	}

	}

	public void constructPageTop(PrintWriter output) {

		String myPageTop = "<html lang=\"en\">"
				+ "<head>	<meta http-equiv=\"Content-Type\" content=\"text/html\"; charset=\"utf-8\" />"
				+ "<title>GameSpeed</title>"
				+ "<script type='text/javascript' src='javascript.js'></script><link rel=\"stylesheet\" href=\"styles.css\" type=\"text/css\" />"
				+ "</head>"
				+ "<body onload='init()'>"
				+ "<div id=\"container\">"
				+ "<header>"
				+ "<h1><a href=\"#\">Game<span>Speed</span></a></h1><h2>connecting gamers</h2>"
				+ "</header>"
				+ "<nav>"
				+ "<ul>"
				+ "<li class=\"\"><a href=\"home.jsp\">Home</a></li>"
				+ "<li><a href=\"#\">Products</a>"
				+ "<ul class=\"dd1\">"
				+ "<li><a href=\"#\">Consoles</a>"
				+ "<ul class=\"dd2\">"
				+ "<li><a href=\"microsoft.jsp\">Microsoft</a></li>"
				+ "<li><a href=\"sony.jsp\">Sony</a></li>"
				+ "<li><a href=\"nintendo.jsp\">Nintendo</a></li>"
				+ "</ul></li>"
				+ "<li><a href=\"#\">Games</a>"
				+ "<ul class=\"dd2\">"
				+ "<li><a href=\"ea.jsp\">Electronic arts</a></li>"
				+ "<li><a href=\"activision.jsp\">Activision</a></li>"
				+ "<li><a href=\"ttint.jsp\">Take-two Interactive</a></li>"
				+ "</ul></li>"
				+ "<li><a href=\"accessories.jsp\">Accessories</a></li>"
				+ "</ul></li>"
				+ "<li><a class='' href='newProducts.jsp'>New Products</a></li> <li><a class=\"selected\" href=\"analytics.html\">Data Analytics</a></li>"
				+ "<li class=\"right\"><a class=\"\" href=\"logout.jsp\"><img src=\"images/logout.png\" width=\"50px\" height=\"50px\" ait=\"logout\" /></a></li>"
				+ "<li class=\"right\"><a class=\"\" href=\"addToCart.jsp\"><img src=\"images/cart.png\" width=\"75px\" height=\"50px\" ait=\"cart\" /></a></li>"
				+ "<li class=\"right\"><a class=\"myorders\" href=\"myOrders.jsp\">My Orders</a></li>"
				+ "<li class='search'><form name='autofillform' action='autocomplete' autocomplete='off' class='searchform' ><table><tr>"
                                + "<td><p><input class='s' id='complete-field' onkeyup='doCompletion()' type='text' size='15' name='s' placeholder='Search product' /></p></td>"
				+ "<td><input class='img' type='image' src='images/search.png' height='20px' width='20px' alt='search' /></td>"
                               	+ "</tr><tr><td id='auto-row' colspan='2'><table id='complete-table' class='popupBox'></table></td></tr></table></form></li>"
				+ "</ul>" + "</nav>"
				+ "<div id=\"body\">" + "<section id=\"rc\">"
				+ "<section id=\"rct\">" + "<article>"
				+ "<h2 class='tp'> Query Results </h2>";

		output.println(myPageTop);

	}

	public void constructPageBottom(PrintWriter output) {
		String myPageBottom = "</article></section></section><aside class=\"sidebar\">"
				+ "<ul><li><h4>Consoles</h4><ul><li><a href=\"microsoft.jsp\">XBOX One</a></li>"
				+ "<li><a href=\"microsoft.jsp\">XBOX 360</a></li>"
				+ "<li><a href=\"sony.jsp\">PS 3</a></li>"
				+ "<li><a href=\"sony.jsp\">PS 4</a></li>"
				+ "<li><a href=\"nintendo.jsp\">Wii</a></li>"
				+ "<li><a href=\"nintendo.jsp\">Wii U</a></li></ul>"
				+ "</li><li><h4>Games</h4>"
				+ "<ul><li><a href=\"ea.jsp\">FIFA 16</a></li>"
				+ "<li><a href=\"activision.jsp\">Call of Duty-Advanced Warfare</a></li>"
				+ "<li><a href=\"ttint.jsp\">Grand Theft Auto V</a></li>"
				+ "</ul></li><li><h4>Accessories</h4>"
				+ "<ul><li><a href=\"accessories.jsp\">Headset</a></li>"
				+ "</ul></li>"
				+ "<li><h4>Trending and Data Analytics</h4><ul><li><a href='analytics.jsp'>Data Analytics</a></li></ul></li>"
				+ "</ul></aside><div class=\"clear\"></div>"
				+ "</div><footer>"
				+ "<div class=\"footer-content\">"
				+ "<h5><a href=\"#\">Reviews</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"#\">Returns</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"#\">Support</a></h5>"
				+ "<div class=\"clear\"></div>"
				+ "</div>"
				+ "<div class=\"footer-bottom\">"
				+ "<p>&copy GAMESPEED 2015 ALL RIGHTS RESERVED</p>"
				+ "</div></footer></div></body></html>";

		output.println(myPageBottom);
	}

	public void constructDefaultContent(DBCursor dbCursor, PrintWriter output,
			boolean countOnly) {
		int count = 0;
		String tableData = " ";
		String pageContent = " ";

		while (dbCursor.hasNext()) {
			BasicDBObject bobj = (BasicDBObject) dbCursor.next();
			tableData = "<tr><td>Name: <b>     "
					+ bobj.getString("productName") + " </b></td></tr>"
					+ "<tr><td>Price:       " + bobj.getInt("productPrice")
					+ "</br>" + "Retailer:            "
					+ bobj.getString("retailerName") + "</br>"
					+ "Retailer Zipcode:    " + bobj.getString("retailerZip")
					+ "</br>" + "Retailer City:       "
					+ bobj.getString("retailerCity") + "</br>"
					+ "Retailer State:      " + bobj.getString("retailerState")
					+ "</br>" + "Sale:                "
					+ bobj.getString("sale") + "</br>"
					+ "User ID:             " + bobj.getString("userID")
					+ "</br>" + "User Age:            "
					+ bobj.getString("userAge") + "</br>"
					+ "User Gender:         " + bobj.getString("userGender")
					+ "</br>" + "User Occupation:     "
					+ bobj.getString("userOccupation") + "</br>"
					+ "Manufacturer:        "
					+ bobj.getString("manufacturerName") + "</br>"
					+ "Manufacturer Rebate: " + bobj.getString("rebate")
					+ "</br>" + "Rating:              "
					+ bobj.getString("reviewRating") + "</br>"
					+ "Date:                " + bobj.getString("reviewDate")
					+ "</br>" + "Review Text:         "
					+ bobj.getString("reviewText") + "</td></tr>";

			count++;

			output.println("<h5>Review# " + count + "</h5>");
			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);
		}

		// No data found
		if (count == 0) {
			pageContent = "<h3>No Data Found</h3>";
			output.println(pageContent);
		}

	}

	public void constructGroupByCityContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";
		String RevCnt = " ";
		String MaxPrice = " ";
		String price1 = " ";
		int n = 1;
		int k = 1;
		
		output.println("<h1> Grouped By - City </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productList = (BasicDBList) bobj.get("Product");
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList price = (BasicDBList) bobj.get("Price");
			
			rowCount++;
										
			if (filterByMaxprice) {
				RevCnt = "1";
				MaxPrice = bobj.getString("MaxPrice");
			}else {
				RevCnt = bobj.getString("Review Count");
				}
			
			if (filterByTop5){
				if(productList.size()>5) {
					productCount = productList.size()-5;
					RevCnt = "5";
				} else {
					productCount = 0;
				}
			}
			
			tableData = "<tr><td>City: " + bobj.getString("City")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ RevCnt + "</td></tr>";
			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);
																		
			// Now print the products with the given review rating				
							
				if (!countOnly) {
				while (productCount < productList.size()) {	
										
					if (filterByMaxprice) {
						price1 = price.get(productCount).toString();
						if (MaxPrice.equals(price1)){
							//k = n++;
							tableData = "<tr rowspan = \"4\"><td> Product: "
									+ productList.get(productCount) + "</br>"
									+ "Rating: " + rating.get(productCount) + "</br>"
									+ "Review: " + productReview.get(productCount) + "</br>"
											+ "Price: : " + price1
									+ "</td></tr>";

							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
							}
							//n = 0;
					} else {
						tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount) + "</br>"
									+ "Price: : " + price.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);
				}
																			
					productCount++;
					
				}
				
				
				/*if(medianPrice) {
					if((productCount) %2 == 0){
						n = (productCount)/2;
					}else{
						n = (productCount+1)/2;
					}
					pageContent = "<table class = \"query-table\"><tr><td>" 
							+"Median of Product Price is: </td><td>" +price.get(n)
									+ "</td></tr></table>";
							output.println(pageContent);
				}*/
				
				// Reset product count
				}
				
				productCount = 0;
			
			
		}
		filterByTop5 = false;
		filterByMaxprice = false;
		
		// No data found
		if (rowCount == 0) {
			pageContent = "<h5>No Data Found</h5>";
			output.println(pageContent);
		}

	}

	public void constructGroupByProductContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Products </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");

			rowCount++;
			tableData = "<tr><td>Product: " + bobj.getString("Product")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"3\"><td>Rating: "
							+ rating.get(reviewCount) + "</br>" + "Review: "
							+ productReview.get(reviewCount) + "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByCategoryContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Product Category </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productList = (BasicDBList) bobj.get("Product");
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			
			rowCount++;
			tableData = "<tr><td>Product Category: " + bobj.getString("Category")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByPriceContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Product Price </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Product Price: " + bobj.getString("Price")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByRetailerContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Retailer Name </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Retailer Name: " + bobj.getString("Retailer")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByStateContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - State </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>State: " + bobj.getString("State")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByZipContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";
		String RevCnt = " ";

		output.println("<h1> Grouped By - Zip Code </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");
			BasicDBList price = (BasicDBList) bobj.get("Price");
			
			if (!filterByMaxprice) {
			RevCnt = bobj.getString("Review Count");
			}else {
				RevCnt = "1";
			}

			rowCount++;
			tableData = "<tr><td>Zip Code: " + bobj.getString("Zip")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);
			
			String MaxPrice = bobj.getString("MaxPrice");

			// Now print the products with the given review rating
			if (!countOnly) {
				while (productCount < productReview.size()) {
					String price1 = price.get(productCount).toString();
					
					if (filterByMaxprice) {
						if (MaxPrice.equals(price1)){
							tableData = "<tr rowspan = \"4\"><td> Product: "
									+ productList.get(productCount) + "</br>"
									+ "Rating: " + rating.get(productCount) + "</br>"
									+ "Review: " + productReview.get(productCount) + "</br>"
											+ "Price: : " + price1
									+ "</td></tr>";

							pageContent = "<table class = \"query-table\">" + tableData
									+ "</table>";
							output.println(pageContent);
							}
					} else {
						tableData = "<tr rowspan = \"4\"><td> Product: "
								+ productList.get(productCount) + "</br>"
								+ "Rating: " + rating.get(productCount) + "</br>"
								+ "Review: " + productReview.get(productCount) + "</br>"
										+ "Price: : " + price1
								+ "</td></tr>";

						pageContent = "<table class = \"query-table\">" + tableData
								+ "</table>";
						output.println(pageContent);
					}
														
					productCount++;
					
				}
				filterByMaxprice = false;
				// Reset product count
				productCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupBySaleContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Products On Sale </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Product on Sale: " + bobj.getString("Sale")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByManufacturerContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Manufacturer </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Manufacturer: " + bobj.getString("Manufacturer")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByRebateContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Manufacturer Rebate </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Manufacturer Rebate: " + bobj.getString("Rebate")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	public void constructGroupByEmailidContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Email ID </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Email ID: " + bobj.getString("Emailid")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByAgeContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Age </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Age: " + bobj.getString("Age")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByGenderContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Gender </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Gender: " + bobj.getString("Gender")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByOccupationContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Occupation </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Occupation: " + bobj.getString("Occupation")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByRatingContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Product Rating </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Product Rating: " + bobj.getString("rating")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
	
	public void constructGroupByDateContent(AggregationOutput aggregate,
			PrintWriter output, boolean countOnly) {
		int rowCount = 0;
		int reviewCount = 0;
		int productCount = 0;
		String tableData = " ";
		String pageContent = " ";

		output.println("<h1> Grouped By - Review Date </h1>");
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			BasicDBList productReview = (BasicDBList) bobj.get("Reviews");
			BasicDBList rating = (BasicDBList) bobj.get("Rating");
			BasicDBList productList = (BasicDBList) bobj.get("Product");

			rowCount++;
			tableData = "<tr><td>Review Date: " + bobj.getString("Date")
					+ "</td>&nbsp" + "<td>Reviews Found: "
					+ bobj.getString("Review Count") + "</td></tr>";

			pageContent = "<table class = \"query-table\">" + tableData
					+ "</table>";
			output.println(pageContent);

			// Now print the products with the given review rating
			if (!countOnly) {
				while (reviewCount < productReview.size()) {
					tableData = "<tr rowspan = \"4\"><td> Product: "
							+ productList.get(productCount) + "</br>"
							+ "Rating: " + rating.get(productCount) + "</br>"
							+ "Review: " + productReview.get(productCount)
							+ "</td></tr>";

					pageContent = "<table class = \"query-table\">" + tableData
							+ "</table>";
					output.println(pageContent);

					reviewCount++;
				}

				// Reset review count
				reviewCount = 0;
			}
		}
		// No data found
		if (rowCount == 0) {
			pageContent = "<h1>No Data Found</h1>";
			output.println(pageContent);
		}
	}
}