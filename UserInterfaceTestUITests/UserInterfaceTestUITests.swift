//
//  UserInterfaceTestUITests.swift
//  UserInterfaceTestUITests
//
//  Created by Vasanth Kumar on 04/08/23.
//

import XCTest

final class UserInterfaceTestUITests: XCTestCase {
    let app = XCUIApplication()
    
    func login() throws {
        app.buttons["Login"].tap()
     
        app.textFields.element.tap()
        app.textFields.element.typeText("test")
     
        app.secureTextFields.element.tap()
        app.secureTextFields.element.typeText("pass")
        app.keyboards.buttons["Return"].tap()
     
        app.buttons["loginNow"].tap()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testWelcome() {
        let welcome = app.staticTexts.element
        XCTAssert(welcome.exists)
        XCTAssertEqual(welcome.label, "Welcome")
    }
    
    func testLogin() {
        let loginButton = app.buttons["loginButton"]
        XCTAssert(loginButton.exists)
        XCTAssertEqual(loginButton.label, "Login")
    }
    
    func testLoginFormAppearance() {
        app.buttons["loginButton"].tap()
        let navBarTitle = app.staticTexts["Login"]
        XCTAssertTrue(navBarTitle.waitForExistence(timeout: 0.5))
    }
    
    func testLoginForm() {
        app.buttons["loginButton"].tap()
        
        let navBar = app.navigationBars.element
        XCTAssert(navBar.exists)
        
        let usernameField = app.textFields["Username"]
        XCTAssert(usernameField.exists)
        
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.exists)
        
        let loginButton = app.buttons["loginNow"]
        XCTAssert(loginButton.exists)
        XCTAssertEqual(loginButton.label, "Login")
        
        let dismiss = app.buttons["Dismiss"]
        XCTAssert(dismiss.exists)
    }
    
    func testFormDismissAction() {
        app.buttons["Login"].tap()
        
        XCTAssert(app.buttons["Dismiss"].exists)
        app.buttons["Dismiss"].tap()
        XCTAssertFalse(app.buttons["Dismiss"].waitForExistence(timeout: 0.5))
    }
    
    func testUsername() {
        app.buttons["Login"].tap()
        
        let username = app.textFields["Username"]
        username.tap()
        username.typeText("test")
        
        XCTAssertNotEqual(username.value as! String, "")
    }
    
    func testPassword() {
        app.buttons["Login"].tap()
        
        let password = app.secureTextFields["Password"]
        password.tap()
        app.keys["p"].tap()
        app.keys["a"].tap()
        app.keys["s"].tap()
        app.keys["s"].tap()
        app.keyboards.buttons["Return"].tap()
        
        XCTAssertNotEqual(password.value as! String, "")
    }
    
    func testLoginNow() {
        app.buttons["Login"].tap()
        
        let username = app.textFields["Username"]
        username.tap()
        username.typeText("test")
        XCTAssertNotEqual(username.value as! String, "")
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText("pass")
        XCTAssertNotEqual(password.value as! String, "")
        app.keyboards.buttons["Return"].tap()
        
        let loginButton = app.buttons["loginNow"]
        loginButton.tap()
        XCTAssertFalse(loginButton.waitForExistence(timeout: 0.5))
    }
    
    func testLoginFail() {
        app.buttons["Login"].tap()
        app.buttons["loginNow"].tap()
        
        XCTAssert(app.alerts.element.waitForExistence(timeout: 0.5))
        
        app.alerts.element.buttons["OK"].tap()
        XCTAssertFalse(app.alerts.element.waitForExistence(timeout: 0.5))
    }
    
    func testWelcomeAfterLogin() throws {
        XCTAssert(app.staticTexts["Welcome"].exists)
                
        try login()
        
        XCTAssert(app.staticTexts["Welcome test"].exists)
    }
    
    func testLoginLogoutLabel() throws {
        XCTAssertEqual(app.buttons["loginButton"].label, "Login")
     
        try login()
     
        XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
    }
    
    func testLogout() throws {
        try login()
        
        XCTAssert(app.staticTexts["Welcome test"].exists)
        XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
        
        app.buttons["loginButton"].tap()
        XCTAssert(app.staticTexts["Welcome"].exists)
        XCTAssertEqual(app.buttons["loginButton"].label, "Login")
    }
    
    func testColorTheme() throws {
        try login()
     
        let colorTheme = app.segmentedControls["colorTheme"]
        XCTAssert(colorTheme.exists)
        XCTAssert(colorTheme.buttons["Light"].isSelected)
     
        colorTheme.buttons["Dark"].tap()
        XCTAssert(colorTheme.buttons["Dark"].isSelected)
    }
    
    func testTextSize() throws {
        try login()
     
        let textSize = app.sliders["slider"]
        XCTAssert(textSize.exists)
     
        textSize.adjust(toNormalizedSliderPosition: 0.75)
        XCTAssertGreaterThanOrEqual(textSize.value as! String, "0.7")
    }
 
    func testFontPicker() throws {
        try login()
     
        let wheel = app.pickerWheels.element
        XCTAssert(wheel.exists)
        XCTAssertEqual(wheel.value as! String, "Arial")
     
        wheel.adjust(toPickerWheelValue: "Futura")
        XCTAssertEqual(wheel.value as! String, "Futura")
    }
    
}
