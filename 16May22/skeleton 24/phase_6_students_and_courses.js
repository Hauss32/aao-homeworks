function Student(first, last) {
    this.first = first;
    this.last = last;
    this.courses = [];
}

Student.prototype.name = function(){
    return `${this.first} ${this.last}`
};

Student.prototype.enroll = function(course) {
    if(this.courses.includes(course)){
        return;
    } else{
        this.hasConflict(course);
        course.addStudent(this);
        this.courses.push(course);
        return;
    }
};

Student.prototype.courseLoad = function() {
    let courseLoad = {};
    this.courses.forEach( (course) => {
        dept = course.department;
        if (courseLoad[dept]) {
            courseLoad[dept] += course.credits;
        } else {
            courseLoad[dept] = course.credits;
        }
    })

    return courseLoad;
};

Student.prototype.hasConflict = function(newCourse){
    this.courses.forEach( course => {
        if( course.conflictsWith(newCourse) ){
            throw `Schedule of ${newCourse.name} conflicts with ${course.name}!`;
        }
    })
};

function Course(name, department, credits, days, time) {
    this.name = name;
    this.department = department;
    this.credits = credits;
    this.students = [];
    this.days = days;
    this.time = time;
}

Course.prototype.addStudent = function(student){
    if (this.students.includes(student)) {
        return;
    } else {
        this.students.push(student);
        return;
    }
};

Course.prototype.conflictsWith = function (course) {
    let hasConflict = false;
    this.days.forEach( day => {
        let overlap_day = course.days.includes(day);
        let overlap_time = this.time === course.time;

        if(overlap_day && overlap_time) { hasConflict = true; }
    })

    return hasConflict;
};

let student1 = new Student('First', 'Student');
let student2 = new Student('Second', 'Student');

let cs101 = new Course('CS101', 'CompSci', 1.0, ['mon', 'wed', 'fri'], 1);
let cs103 = new Course('CS103', 'CompSci', .5, ['mon', 'wed', 'fri'], 2);
let ls101 = new Course('LS101', 'LifeSci', 1.0, ['mon', 'wed', 'fri'], 1);

console.log('Begin testing...');
console.log('All logs should return true until expected logged error.');

console.log(student1.name() === 'First Student');

//enroll first student
student1.enroll(cs101);
console.log(student1.courses.length === 1);
console.log(cs101.students.length === 1);
console.log(student1.courseLoad()[cs101.department] === 1.0);

//try to double-enroll
student1.enroll(cs101);
console.log(student1.courses.length === 1);
console.log(cs101.students.length === 1);
console.log(student1.courseLoad()[cs101.department] === 1.0);

//enroll second student
student2.enroll(cs101);
console.log(cs101.students.length === 2);
console.log(student2.courseLoad()[cs101.department] === 1.0);

//enroll first student in second course of same dept.
student1.enroll(cs103);
console.log(student1.courses.length === 2);
console.log(student1.courseLoad()[cs101.department] === 1.5);

//log conflict error
try {
    student1.enroll(ls101);
    console.log('False. This should have raised an error!');
} catch (error) {
    console.log(`True. ${error}`);
}