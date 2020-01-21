import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {

  public form = new FormGroup({
    desiredAmount: new FormControl(1234),
    waterNeeded: new FormControl(1000),
    coffeeNeeded: new FormControl(42),
    brewRatio: new FormControl(17),
    waterAbsorbed: new FormControl(2)
  });

  ngOnInit(): void {
    this.form.controls.desiredAmount.valueChanges.subscribe(desired => {
      const ratio = this.form.controls.brewRatio.value;
      this.form.controls.coffeeNeeded.setValue(desired / ratio);
    });

    this.form.controls.coffeeNeeded.valueChanges.subscribe(coffeeNeeded => {
      const desired = this.form.controls.desiredAmount.value;
      const absorbed = this.form.controls.waterAbsorbed.value;
      this.form.controls.waterNeeded.setValue(desired + coffeeNeeded * absorbed);
    });

    this.form.controls.brewRatio.valueChanges.subscribe(ratio => {
      const desired = this.form.controls.desiredAmount.value;
      this.form.controls.coffeeNeeded.setValue(desired / ratio);
    });

    this.form.controls.waterAbsorbed.valueChanges.subscribe(absorbed => {
      const coffee = this.form.controls.coffeeNeeded.value;
      const desired = this.form.controls.desiredAmount.value;
      this.form.controls.waterNeeded.setValue(desired + coffee * absorbed);
    });

    this.form.controls.desiredAmount.setValue(1000);
  }

}
