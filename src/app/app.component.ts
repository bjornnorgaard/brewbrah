import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{

  public form = new FormGroup({
    wantedAmountMl: new FormControl(1000),
    waterNeeded: new FormControl(1115),
    coffeeGram: new FormControl(60),
    brewRatio: new FormControl(17),
    wastedWaterPerGramCoffee: new FormControl(2)
  });

  ngOnInit(): void {
  }

}
