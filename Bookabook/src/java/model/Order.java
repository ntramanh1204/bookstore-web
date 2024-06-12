
package model;

public class Order {

    private int id;
    private Account account;
    private String orderdate;
    private String status;

    public Order() {
    }

    public Order(int id, Account account, String orderdate, String status) {
        this.id = id;
        this.account = account;
        this.orderdate = orderdate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public String getOrderdate() {
        return orderdate;
    }

    public void setOrderdate(String orderdate) {
        this.orderdate = orderdate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", account=" + account + ", orderdate=" + orderdate + ", status=" + status + '}';
    }

}
