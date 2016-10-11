require "rails_helper"
include ControllerHelpers::BookingsHelper

RSpec.describe BookingsController do
  before(:all) do
    @flight = create(:flight)
    @user = create(:user)
    @bookings = create_list(:booking, 3)
  end

  describe "GET #new_booking_page" do
    let(:new_booking_page_action) do
      get :new_booking_page,
          flight_id: @flight.id
    end
    it "should render the new template" do
      expect(new_booking_page_action).to render_template(:new_booking_page)
    end

    it "should respond with status 200" do
      expect(new_booking_page_action).to have_http_status :ok
    end

    it "should assign @booking to a new Booking object" do
      get :new_booking_page, flight_id: @flight.id
      expect(assigns[:booking]).to be_a_new(Booking)
    end
  end

  describe "POST #new_booking_details" do
    it "should redirect user to payment page" do
      post :new_booking_details, booking: VALID_BOOKING_DETAILS
      expect(controller).to respond_with(302)
      expect(:notice).to be_present
    end
  end

  describe "GET #create_booking" do
    let(:create_booking_action) do
      get :create_booking,
          session[:info] = create_booking_params.deep_stringify_keys
    end
    it "should respond to expectations" do
      expect(create_booking_action).
        to redirect_to(booking_path(assigns[:booking]))

      expect(create_booking_action).to have_http_status(302)
    end

    it "should increase the number of bookings by 1" do
      expect { create_booking_action }.to change(Booking, :count).by(1)
    end

    it "should create a booking record" do
      get :create_booking,
          session[:info] = create_booking_params.deep_stringify_keys
      expect(assigns[:booking]).to be_persisted
    end

    it "should increase ActionMailer::Base.deliveries by 1" do
      expect { create_booking_action }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end
  end

  describe "GET #show" do
    it "should show information for a particular booking" do
      get :show, id: @bookings.first
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    let(:index_action) { get :index }
    it "should redirect anonymous user to login page" do
      expect(index_action).to redirect_to(new_user_session_path)
    end

    it "should redirect with status code 302" do
      expect(index_action).to have_http_status(302)
    end
    context "for a Signed-in User" do
      let(:sign_in_action) { sign_in(@bookings.first.user) }
      it "should return the list of bookings by a logged-in user" do
        sign_in_action
        expect(index_action).to render_template("index")
      end

      it "should return bookings that belongs to the user" do
        sign_in_action
        get :index
        expect(assigns[:bookings]).to include(@bookings.first)
      end
    end
  end

  describe "GET #edit" do
    let(:edit_action) { get :edit, id: @bookings.first.id }
    it "should redirect anonymous user to login page" do
      expect(edit_action).to redirect_to(new_user_session_path)
    end

    it "should redirect with status code 302" do
      expect(edit_action).to have_http_status(302)
    end

    it "should allow the user to access edit page" do
      sign_in(@bookings.first.user)
      expect(edit_action).to render_template(:edit)
    end

    it "should assign the booking to a variable" do
      sign_in(@bookings.first.user)
      get :edit, id: @bookings.first.id
      expect(assigns(:booking)).to eq(@bookings.first)
    end
  end

  describe "PUT #update" do
    it "should update the booking with valid parameters" do
      sign_in(@bookings.first.user)
      VALID_BOOKING_DETAILS[:passengers_attributes] <<
        {
          name: Faker::Name.name,
          email: Faker::Internet.email
        }
      put :update, id: @bookings.first, booking: VALID_BOOKING_DETAILS
      expect(controller).to respond_with(302)
      expect(:notice).to be_present
    end

    it "should redirect user with invalid booking parameters" do
      sign_in(@bookings.second.user)
      VALID_BOOKING_DETAILS[:passengers_attributes] <<
        {
          name: nil,
          email: Faker::Internet.email
        }
      put :update, id: @bookings.second, booking: VALID_BOOKING_DETAILS
      expect(response).to redirect_to(edit_booking_path)
    end
  end

  describe "GET #search_result" do
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

  describe "DELETE #destroy" do
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
