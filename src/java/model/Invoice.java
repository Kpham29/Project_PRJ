/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.math.BigDecimal;
import java.sql.Date;
/**
 *
 * @author HBDELL
 */
public class Invoice {
    private int invoiceId;
    private int bikeId;
    private int userId;
    private Date orderDate;
    private Date expectedDate;
    private String status;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private BigDecimal amountPaid;
    private String notes;
    
    private Bike bike;
    private User user;

    public Invoice() {
    }

    public Invoice(int invoiceId, int bikeId, int userId, Date orderDate, Date expectedDate, String status, BigDecimal totalAmount, String paymentMethod, BigDecimal amountPaid, String notes) {
        this.invoiceId = invoiceId;
        this.bikeId = bikeId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.expectedDate = expectedDate;
        this.status = status;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.amountPaid = amountPaid;
        this.notes = notes;
    }

    

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getBikeId() {
        return bikeId;
    }

    public void setBikeId(int bikeId) {
        this.bikeId = bikeId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getExpectedDate() {
        return expectedDate;
    }

    public void setExpectedDate(Date expectedDate) {
        this.expectedDate = expectedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }


    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Bike getBike() {
        return bike;
    }

    public void setBike(Bike bike) {
        this.bike = bike;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getAmountPaid() {
        return amountPaid;
    }

    public void setAmountPaid(BigDecimal amountPaid) {
        this.amountPaid = amountPaid;
    }
    
    
}
