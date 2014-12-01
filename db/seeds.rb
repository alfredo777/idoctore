# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#ManagerUser.create(email: 'jardarubydv@gmail.com', password: 'alfredo2008', identify: 1234567, seller_code: '234890222CFG',  seller: true)

######## crando usuarios ########

@doctor_test = User.create(name: "German Carrillo", email: "gemacafl@gmail.com" , hashed_password: "12345678", confirmed: true, role: "doctor", sex: "male", terms: true, cadre_card: "1235-german", payment_method: true, date_of_birth: Time.now)

@patient_test_1 = User.create(name: "Mario Perez Jimenez", email: "gemacafl+1@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "male", terms: true, date_of_birth: Time.now )
@patient_test_2 = User.create(name: "Juan Sandobal Iñiguez", email: "gemacafl+2@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "male", terms: true, date_of_birth: Time.now )
@patient_test_3 = User.create(name: "Asunción Carrasco Dominguez", email: "gemacafl+3@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_4 = User.create(name: "Maria Rodriguez Sanchez", email: "gemacafl+4@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_5 = User.create(name: "Juana Maritza Reyes Marquez", email: "gemacafl+5@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_6 = User.create(name: "Mariano Brizuela Rodriguez", email: "gemacafl+6@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "male", terms: true, date_of_birth: Time.now )
@patient_test_7 = User.create(name: "Alvaro Quintero Sarzuela", email: "gemacafl+7@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "male", terms: true, date_of_birth: Time.now )
@patient_test_8 = User.create(name: "Domingo Aparicio Perez", email: "gemacafl+8@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "male", terms: true, date_of_birth: Time.now)
@patient_test_9 = User.create(name: "Fernanda Esquivel Martinez", email: "gemacafl+9@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_10 = User.create(name: "Petra Alamaraz Diaz", email: "gemacafl+10@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_11= User.create(name: "Jacinta Vazquez Medrano", email: "gemacafl+11@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_12= User.create(name: "Gloria de la Asunción Fierro", email: "gemacafl+12@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_13= User.create(name: "José Guadalupe Palacios Martinez", email: "gemacafl+13@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "male", terms: true, date_of_birth: Time.now )
@patient_test_14 = User.create(name: "Luis Alfredo Rangel Ramirez  ", email: "gemacafl+14@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "male", terms: true, date_of_birth: Time.now )
@patient_test_15 = User.create(name: "Georgina Perez Martinez", email: "gemacafl+15@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )
@patient_test_16 = User.create(name: "Aline Coautine Velazquez", email: "gemacafl+16@gmail.com", hashed_password: "12345678", confirmed: true, role: "patient", sex: "female", terms: true, date_of_birth: Time.now )

@dp1 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_1.id, accepted_request: true)
@dp2 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_2.id, accepted_request: true)
@dp3 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_3.id, accepted_request: true)
@dp4 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_4.id, accepted_request: true)
@dp5 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_5.id, accepted_request: true)
@dp6 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_6.id, accepted_request: true)
@dp7 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_7.id, accepted_request: true)
@dp8 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_8.id, accepted_request: true)
@dp9 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_9.id, accepted_request: true)
@dp10 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_10.id, accepted_request: true)
@dp11 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_11.id, accepted_request: true)
@dp12 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_12.id, accepted_request: true)
@dp13 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_13.id, accepted_request: true)
@dp14 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_14.id, accepted_request: true)
@dp15 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_15.id, accepted_request: true)
@dp16 = DoctorPatient.create(doctor_id: @doctor_test.id , patient_id: @patient_test_16.id, accepted_request: true)