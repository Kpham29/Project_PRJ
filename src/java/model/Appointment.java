/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
/**
 *
 * @author HBDELL
 */
public class Appointment {
    private int appointmentId;
    private int customerId;
    private int vehicleId;
    private int serviceId;
    private Date appointmentTime;
    private String description;
    private String status;
    
    private Customer customer;
    private Bike vehicle;
    private Service service;

    public Appointment() {
    }

    public Appointment(int appointmentId, int customerId, int vehicleId, int serviceId, Date appointmentTime, String description, String status) {
        this.appointmentId = appointmentId;
        this.customerId = customerId;
        this.vehicleId = vehicleId;
        this.serviceId = serviceId;
        this.appointmentTime = appointmentTime;
        this.description = description;
        this.status = status;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public Date getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(Date appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Bike getVehicle() {
        return vehicle;
    }

    public void setVehicle(Bike vehicle) {
        this.vehicle = vehicle;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }
    
    
}
