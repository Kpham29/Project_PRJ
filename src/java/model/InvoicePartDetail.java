/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author HBDELL
 */
public class InvoicePartDetail {
    private int id;
    private int invoiceId;
    private int partId;
    private int quantity;
    private BigDecimal unitPrice;
    
    private Invoice invoice;
    private SparePart part;

    public InvoicePartDetail() {
    }

    public InvoicePartDetail(int id, int invoiceId, int partId, int quantity, BigDecimal unitPrice) {
        this.id = id;
        this.invoiceId = invoiceId;
        this.partId = partId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getPartId() {
        return partId;
    }

    public void setPartId(int partId) {
        this.partId = partId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public SparePart getPart() {
        return part;
    }

    public void setPart(SparePart part) {
        this.part = part;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    
}
