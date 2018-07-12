require 'spec_helper'

TIMECOP = Time.now

describe EventPolicy do
  let(:policy) { EventPolicy.new(start_time: TIMECOP, current_time: TIMECOP + offset) }
  let(:offset) { 0 }

  describe "#initialization" do
    context "when current time is before start time" do
      let(:offset) { -1 }

      it "raises an error" do
        expect { policy }.to raise_error ArgumentError
      end
    end
  end

  describe "#can_upload?" do
    let(:can_upload) { policy.can_upload? }

    context "up to 24 hours after starting the event" do
      let(:offset) { 24.hours }

      it "can upload" do
        expect(can_upload).to be true
      end
    end

    context "just after 24 hours" do
      let(:offset) { 24.hours + 1 }

      it "cannot upload" do
        expect(can_upload).to be false
      end
    end
  end

  describe "#can_download?" do
    let(:can_download) { policy.can_download? }

    context "up to 14 days after starting the event" do
      let(:offset) { 14.days }

      it "can download" do
        expect(can_download).to be true
      end
    end

    context "just after 14 days" do
      let(:offset) { 14.days + 1 }

      context "without payment" do
        it "cannot download" do
          expect(can_download).to be false
        end
      end

      context "with payment" do
        it "can download" do
          policy.payment_at = TIMECOP + offset
          expect(can_download).to be true
        end

        context "after an additional 30 days" do
          it "can download" do
            policy.payment_at = TIMECOP + offset
            policy.current_time = policy.payment_at + 30.days
            expect(can_download).to be true
          end
        end

        context "just after the additional 30 days" do
          it "cannot download" do
            policy.payment_at = TIMECOP + offset
            policy.current_time = policy.payment_at + 30.days + 1
            expect(can_download).to be false
          end
        end
      end
    end

    context "just after 30 days" do
      let(:offset) { 30.days + 1 }

      it "cannot_download" do
        expect(can_download).to be false
      end

      context "with payment after 30 days" do
        it "cannot download" do
          policy.payment_at = policy.current_time
          expect(can_download).to be false
        end
      end
    end
  end
end
