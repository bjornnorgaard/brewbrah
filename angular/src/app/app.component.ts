import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { AngularFireAnalytics } from '@angular/fire/analytics';
import { debounceTime } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {

  public goToSourceClicked = false;

  public form = new FormGroup({
    desiredAmount: new FormControl(1234),
    waterNeeded: new FormControl(1000),
    coffeeNeeded: new FormControl(42),
    brewRatio: new FormControl(17),
    waterAbsorbed: new FormControl(2)
  });

  constructor(private analytics: AngularFireAnalytics) {
  }

  ngOnInit(): void {
    this.form.controls.desiredAmount.valueChanges.subscribe(desired => {
      const ratio = this.form.controls.brewRatio.value;
      this.form.controls.coffeeNeeded.setValue(AppComponent.roundToDecimals(desired / ratio));
    });

    this.form.controls.coffeeNeeded.valueChanges.subscribe(coffeeNeeded => {
      const desired = this.form.controls.desiredAmount.value;
      const absorbed = this.form.controls.waterAbsorbed.value;
      this.form.controls.waterNeeded.setValue(AppComponent.roundToDecimals(desired + coffeeNeeded * absorbed));
    });

    this.form.controls.brewRatio.valueChanges.subscribe(ratio => {
      const desired = this.form.controls.desiredAmount.value;
      this.form.controls.coffeeNeeded.setValue(AppComponent.roundToDecimals(desired / ratio));
    });

    this.form.controls.waterAbsorbed.valueChanges.subscribe(absorbed => {
      const coffee = this.form.controls.coffeeNeeded.value;
      const desired = this.form.controls.desiredAmount.value;
      this.form.controls.waterNeeded.setValue(AppComponent.roundToDecimals(desired + coffee * absorbed));
    });

    this.form.controls.desiredAmount.setValue(1000);

    this.form.valueChanges.pipe(debounceTime(1000)).subscribe(formValue => {
      this.analytics.logEvent('brew_calculated', { brew: formValue });
    });
  }

  public goToSource(): void {
    this.analytics.logEvent('go_to_source_clicked', {brew: this.form.value})
      .then(() => {
        this.goToSourceClicked = true;
        window.location.href = 'https://github.com/bjornnorgaard/brewbrah';
      });
  }

  private static roundToDecimals(num: number, decimals: number = 0): number {
    const roundTo = 10 ^ decimals;
    return Math.round(num * (roundTo)) / roundTo;
  }
}
