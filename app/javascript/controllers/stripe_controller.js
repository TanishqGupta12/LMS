import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stripe"
export default class extends Controller {
  static targets = [ "ticket", "course", "user",'Discount',"discount_amount" ,'total_amount']

  connect() {
    // console.log("stripe");

    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "positionClass": "toast-top-right",
        "preventDuplicates": true,
      }
  }

  amount (event){
    event.preventDefault()

    var csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    var userId = this.userTarget.value
    var courseId = this.courseTarget.value 
    var ticket = this.ticketTarget.value
    var Discount = this.DiscountTarget.value


    if (!Discount) {
        toastr.warning("Please Apply Discount Code")
        return ;
    }

    $.ajax({
      url: `/discount/amount`,
      method: "POST",
      dataType: "json",
      data : {
        userId: userId,
        courseId: courseId,
        ticket: ticket,
        Discount: Discount,
      },
      headers: {
        'X-CSRF-Token': csrfToken 
      },
      success: (response) => {
        // console.log(response);

        this.discount_amountTarget.textContent = response.discount_amount;
        this.total_amountTarget.textContent = response.total_amount;
      
        toastr.success("Discount applied successfully!")
      },
      error: (xhr) => {
        toastr.warning(xhr.responseText)
        console.log(xhr.responseText);
        
      }
    })
  }

  payment (event){
    event.preventDefault()

    var csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    var userId = this.userTarget.value
    var courseId = this.courseTarget.value 
    var ticket = this.ticketTarget.value
    var Discount = this.DiscountTarget.value
    var total_amounts = this.total_amountTarget.textContent;

    $.ajax({
      url: `/create`,
      method: "POST",
      dataType: "json",
      data : {
        userId: userId,
        courseId: courseId,
        ticket: ticket,
        Discount: Discount,
        total_amount: total_amounts
      },
      headers: {
        'X-CSRF-Token': csrfToken 
      },
      success: (response) => {
      
        toastr.success("okkk!")
      },
      error: (xhr) => {
        toastr.warning(xhr.responseText)
        console.log(xhr.responseText);
        
      }
    })
  }
}