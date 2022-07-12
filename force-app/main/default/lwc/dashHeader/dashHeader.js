import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class DashHeader extends NavigationMixin (LightningElement) {

    //buttons
    NavigateToAccountDetails(){
        console.log("nav");
        this[NavigationMixin.Navigate]({
            //type: 'standard__component',
            //type:'standard_navItemPage',
            type: 'standard__webPage',
        attributes: {
            url: 'https://mindful-wolf-u62s68-dev-ed.lightning.force.com/lightning/n/Account_details'
            //apiName: 'Account_details'
            //componentName:'accountDetails' 
            },
        });
        console.log("navvvvvvvvvv");
    }

    NavigateToContactDetails(){
        console.log("nav");
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://mindful-wolf-u62s68-dev-ed.lightning.force.com/lightning/n/Contacts_Audit_Details'
            },
        });
        console.log("navvvvvvvvvv");
    }

    NavigateToContractDetails(){
        console.log("nav");
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://mindful-wolf-u62s68-dev-ed.lightning.force.com/lightning/n/Contract_Details'
            },
        });
        console.log("navvvvvvvvvv");
    }

    NavigateToLeadDetails(){
        console.log("nav");
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://mindful-wolf-u62s68-dev-ed.lightning.force.com/lightning/n/Lead_Details'
           },
        });
        console.log("navvvvvvvvvv");
    }

    NavigateToOpportunityDetails(){
        console.log("nav");
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://mindful-wolf-u62s68-dev-ed.lightning.force.com/lightning/n/Opportunity_Details'
           },
        });
        console.log("navvvvvvvvvv");
    }

    NavigateToProductDetails(){
        console.log("nav");
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://mindful-wolf-u62s68-dev-ed.lightning.force.com/lightning/n/Product_Details'
            },
        });
        console.log("navvvvvvvvvv");
    }
    


  /*

  handleClick(event) {
    console.log("event");
    console.log(event);
   /* event.preventDefault();
    this[NavigationMixin.Navigate]({
     type: 'standard__component',
     attributes: {
         componentName: 'c__QuoteNew'
     },
      
 });*//*
 event.preventDefault();
 let componentDef = {
    componentDef: "c:newQuote",
    attributes: {
        label: 'Navigated From Another LWC Without Using Aura'
    }
};
let encodedComponentDef = btoa(JSON.stringify(componentDef));
this[NavigationMixin.Navigate]({
    type: 'standard__webPage',
    attributes: {
        url: '/one/one.app#' + encodedComponentDef
    }
});
}


  */}