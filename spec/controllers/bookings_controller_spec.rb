require "rails_helper"

RSpec.describe BookingsController do
  before(:all) do
    @flight = create(:flight)
    @user = create(:user)
    @bookings = create_list(:booking, 3)
  end

  let(:valid_booking_params) do
    {
      booking_ref_code: Faker::Code.asin,
      total_price: Faker::Commerce.price,
      flight_id: @flight.id,
      user_id: @user.id,
      passengers_attributes:
    [{
      name: Faker::Name.name,
      email: Faker::Internet.email
    }]
    }
  end

  context "GET #new" do
    it "should render the new template" do
      get :new, flight_id: @flight.id
      expect(response).to render_template(:new)
    end

    it "should respond with status 200" do
      get :new, flight_id: @flight.id
      expect(controller).to respond_with :ok
    end

    it "should assign @booking to a new Booking object" do
      get :new, flight_id: @flight.id
      expect(assigns(:booking)).to be_a_new(Booking)
    end
  end

  context "GET #show" do
    it "should show information for a particular booking" do
      get :show, id: @bookings.first
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  context "GET #index" do
    it "should redirect anonymous user to login page" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should redirect with status code 302" do
      get :index
      expect(controller).to respond_with(302)
    end

    it "should return the list of bookings by a logged-in user" do
      sign_in(@bookings.first.user)
      get :index
      expect(response).to render_template("index")
    end

    it "should return bookings that belongs to the user" do
      sign_in(@bookings.first.user)
      get :index
      expect(assigns(:bookings)).to include(@bookings.first)
    end
  end

  context "GET #edit" do
    it "should redirect anonymous user to login page" do
      get :edit, id: @bookings.first.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should redirect with status code 302" do
      get :edit, id: @bookings.first.id
      expect(controller).to respond_with(302)
    end

    it "should allow the user to access edit page" do
      sign_in(@bookings.first.user)
      get :edit, id: @bookings.first.id
      expect(response).to render_template(:edit)
    end

    it "should assign the booking to a variable" do
      sign_in(@bookings.first.user)
      get :edit, id: @bookings.first.id
      expect(assigns(:booking)).to eq(@bookings.first)
    end
  end

  context "POST #create" do
    it "should redirect user to payment page" do
      post :create, booking: valid_booking_params
      expect(controller).to respond_with(302)
      expect(:notice).to be_present
    end
  end

  context "PUT #update" do
    it "should update the booking with valid parameters" do
      sign_in(@bookings.first.user)
      valid_booking_params[:passengers_attributes] <<
        {
          name: Faker::Name.name,
          email: Faker::Internet.email
        }
      put :update, id: @bookings.first, booking: valid_booking_params
      expect(controller).to respond_with(302)
      expect(:notice).to be_present
    end

    it "should redirect user with invalid booking parameters" do
      sign_in(@bookings.second.user)
      valid_booking_params[:passengers_attributes] <<
        {
          name: nil,
          email: Faker::Internet.email
        }
      put :update, id: @bookings.second, booking: valid_booking_params
      expect(response).to redirect_to(edit_booking_path)
    end
  end

  context "GET #search_result" do
    it "should redirect user to the booking show page" do
      sign_in(@bookings.second.user)
      get :search_result, booking_ref_code: @bookings.second.booking_ref_code
      expect(response).to redirect_to(booking_path(@bookings.second.id))
    end

    it "should redirect back to the booking search page" do
      sign_in(@bookings.first.user)
      get :search_result, booking_ref_code: 123_456_789
      expect(response).to redirect_to(search_booking_path)
    end
  end

  context "DELETE #destroy" do
    it "should redirect anonymous user to login page" do
      delete :destroy, id: @bookings.first.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should delete the booking with the supplied ID" do
      sign_in(@bookings.first.user)
      delete :destroy, id: @bookings.first.id
      expect(Booking.exists?(@bookings.first)).to be_falsy
    end

    it "should reduce the bookings count by 1" do
      sign_in(@bookings.second.user)
      expect { delete :destroy, id: @bookings.second.id }.
        to change(Booking, :count).by(-1)
    end

    it "should redirect the user to bookings page" do
      sign_in(@bookings.third.user)
      delete :destroy, id: @bookings.third.id
      expect(response).to redirect_to(bookings_path)
    end
  end
end
