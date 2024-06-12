package model;

public class Product {
    private String id;
    private String title;
    private String author;
    private Genre genre;
    double price;
    private int quantity;
    private String authorInformation;
    private String publicationDate;
    private String bookDescription;
    private String imagePath;
    private double rating;

    public Product() {
    }

    public Product(String id, String title, String author, Genre genre, double price, int quantity, String authorInformation, String publicationDate, String bookDescription, String imagePath, double rating) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.price = price;
        this.quantity = quantity;
        this.authorInformation = authorInformation;
        this.publicationDate = publicationDate;
        this.bookDescription = bookDescription;
        this.imagePath = imagePath;
        this.rating = rating;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getAuthorInformation() {
        return authorInformation;
    }

    public void setAuthorInformation(String authorInformation) {
        this.authorInformation = authorInformation;
    }

    public String getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(String publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getBookDescription() {
        return bookDescription;
    }

    public void setBookDescription(String bookDescription) {
        this.bookDescription = bookDescription;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", title=" + title + ", author=" + author + ", genre=" + genre + ", price=" + price + ", quantity=" + quantity + ", authorInformation=" + authorInformation + ", publicationDate=" + publicationDate + ", bookDescription=" + bookDescription + ", imagePath=" + imagePath + ", rating=" + rating + '}';
    }


    
    
}
